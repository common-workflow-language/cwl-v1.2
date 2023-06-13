import logging
import os
import posixpath
from functools import lru_cache
from typing import Dict, List, Optional, Tuple, Type, TypedDict, Union, cast
from typing_extensions import NotRequired, TypeAlias, TypeGuard
from urllib.parse import urljoin, urlparse

import jsonschema
import requests
import pytest
from jsonschema.protocols import Validator
from jsonschema.exceptions import ValidationError, best_match

# WARNING: do not use 'pyyaml' (import yaml), it does invalid parsing of some scientific number representations
# see 'Numbers in scientific notation without dot are parsed as string' (https://github.com/yaml/pyyaml/issues/173)
# builtin 'json' and 'simplejson' also have this issue (https://github.com/common-workflow-language/cwl-v1.2/issues/252)
from ruamel import yaml
from ruamel.yaml.scanner import ScannerError

# https://raw.githubusercontent.com/common-workflow-language/cwl-v1.2/1.2.1_proposed/conformance_tests.yaml
CONFORMANCE_TESTS_FILE = os.path.join(os.path.dirname(__file__), "../../conformance_tests.yaml")
# https://raw.githubusercontent.com/common-workflow-language/cwl-v1.2/1.2.1_proposed/json-schema/cwl.yaml
CWL_JSON_SCHEMA_FILE = os.path.join(os.path.dirname(__file__), "../../json-schema/cwl.yaml")
CWL_JSON_SCHEMA_REF = f"{CWL_JSON_SCHEMA_FILE}#/$defs/CWL"

LOGGER = logging.getLogger(__name__)

# pylint: disable=C0103,invalid-name
Number = Union[int, float]
ValueType = Union[str, Number, bool]
AnyValueType = Optional[ValueType]
# add more levels of explicit definitions than necessary to simulate JSON recursive structure better than 'Any'
# amount of repeated equivalent definition makes typing analysis 'work well enough' for most use cases
_JSON: TypeAlias = "JSON"
_JsonObjectItemAlias: TypeAlias = "_JsonObjectItem"
_JsonListItemAlias: TypeAlias = "_JsonListItem"
_JsonObjectItem = Dict[str, Union[AnyValueType, _JSON, _JsonObjectItemAlias, _JsonListItemAlias]]
_JsonListItem = List[Union[AnyValueType, _JSON, _JsonObjectItem, _JsonListItemAlias]]
_JsonItem = Union[AnyValueType, _JSON, _JsonObjectItem, _JsonListItem]
JSON = Union[Dict[str, Union[_JSON, _JsonItem]], List[Union[_JSON, _JsonItem]], AnyValueType]

ConformanceTestDef = TypedDict(
    "ConformanceTestDef",
    {
        "id": str,
        "doc": str,
        "tags": List[str],  # should contain 'json_schema_invalid' to XFAIL schema validation tests
        "tool": str,
        "job": NotRequired[str],  # not used, for running the actual CWL
        "output": JSON,  # not used, output of CWL execution
        "should_fail": NotRequired[bool],  # indicates failure as "execute failing", but potentially still valid CWL
    }
)


@lru_cache(maxsize=None)
def is_remote_file(file_location: str) -> TypeGuard[str]:
    """
    Parses to file location to figure out if it is remotely available or a local path.
    """
    cwl_file_path_or_url = file_location.replace("file://", "")
    scheme = urlparse(cwl_file_path_or_url).scheme
    return scheme != "" and not posixpath.ismount(f"{scheme}:")  # windows partition


@lru_cache(maxsize=None)
def load_file(file_path: str, text: bool = False) -> Union[JSON, str]:
    """
    Load :term:`JSON` or :term:`YAML` file contents from local path or remote URL.

    If URL, get the content and validate it by loading, otherwise load file directly.

    :param file_path: Local path or URL endpoint where file to load is located.
    :param text: load contents as plain text rather than parsing it from :term:`JSON`/:term:`YAML`.
    :returns: loaded contents either parsed and converted to Python objects or as plain text.
    :raises ValueError: if YAML or JSON cannot be parsed or loaded from location.
    """
    try:
        if is_remote_file(file_path):
            headers = {"Accept": "text/plain"}
            resp = requests.get(file_path, headers=headers)
            if resp.status_code != 200:
                raise ValueError("Loading error: [%s]", file_path)
            return resp.content if text else yaml.safe_load(resp.content)
        with open(file_path, mode="r", encoding="utf-8") as f:
            return f.read() if text else yaml.safe_load(f)
    except OSError as exc:
        LOGGER.debug("Loading error: %s", exc, exc_info=exc)
        raise
    except ScannerError as exc:  # pragma: no cover
        LOGGER.debug("Parsing error: %s", exc, exc_info=exc)
        raise ValueError("Failed parsing file content as JSON or YAML.")


def resolve_ref(schema_file: str) -> Tuple[str, JSON, JSON]:
    schema_path = []
    if "#" in schema_file:
        schema_file, schema_ref = schema_file.split("#", 1)
        schema_path = [ref for ref in schema_ref.split("/") if ref]
    schema_base = schema = load_file(schema_file)
    if schema_path:
        for part in schema_path:
            schema = schema[part]
    # ensure local schema can find relative $ref, since the provided reference can be a sub-schema (with "#/...")
    schema_uri = f"file://{schema_file}" if schema_file.startswith("/") else schema_file
    return schema_uri, schema_base, schema


def load_conformance_tests(test_file: str) -> List[ConformanceTestDef]:
    conformance_tests = load_file(test_file)
    assert isinstance(conformance_tests, list)
    assert all(isinstance(conf_test, dict) for conf_test in conformance_tests)
    test_base = os.path.dirname(test_file)
    all_conf_test = []
    for conf_test in conformance_tests:
        if "$import" in conf_test:
            conf_path = urljoin(f"{test_base}/", conf_test["$import"])
            conf_test = load_conformance_tests(conf_path)
            all_conf_test.extend(conf_test)
            continue
        for ref in ["job", "tool"]:
            if ref not in conf_test:
                continue
            if not urlparse(conf_test[ref]).scheme:
                conf_test[ref] = urljoin(f"{test_base}/", conf_test[ref])
        conf_test.setdefault("doc", "<undefined>")
        all_conf_test.append(conf_test)
    return all_conf_test


@pytest.mark.parametrize(
    "conformance_test",
    load_conformance_tests(CONFORMANCE_TESTS_FILE)
)
def test_conformance(conformance_test: ConformanceTestDef, request: pytest.FixtureRequest) -> None:
    LOGGER.debug(
        "Testing [%s] (%s) with [%s]",
        conformance_test["id"],
        conformance_test["doc"],
        conformance_test["tool"],
    )

    # if the tool CWL is a '$graph' with a reference in the IRI (tool-path.cwl#nested), ignore the nested reference
    # this is because the main 'CWL' JSON schema expect 'cwlVersion' at the root of all documents
    # if we test the nested tool directly against 'CWL', JSON schema will fail immediately
    # also, we evaluate more test cases if we always consider the full sample tool
    instance_file = conformance_test["tool"].rsplit("#")[0]
    instance = load_file(instance_file)
    instance_xfail = "json_schema_invalid" in conformance_test.get("tags", [])
    request.applymarker(pytest.mark.xfail(reason="Test tagged with 'json_schema_invalid'.", condition=instance_xfail))

    schema_uri, schema_base, schema_test = resolve_ref(CWL_JSON_SCHEMA_REF)
    validator: Type[Validator] = jsonschema.validators.validator_for(schema_base)
    validator.resolver = jsonschema.RefResolver(base_uri=schema_uri, referrer=schema_base)

    try:
        # similar to 'validate()' call that raises directly, but obtain the error for more context
        # useful to get more context for 'oneOf' cases that only show "is not valid under any of the given schemas"
        schema_validator = validator(schema_base).evolve(schema=schema_test)
        errors = list(schema_validator.iter_errors(instance))
        if errors:
            if len(errors) == 1 and "oneOf" in errors[0].schema:
                error = errors[0]
                error.message += "\n\nFor each case under oneOf:\n" + "\n".join(
                    f"- {err.message}"
                    if not err.message.endswith("is not valid under any of the given schemas")
                    else f"- all invalid under oneOf {err.validator_value}"
                    for err in error.context
                )
                raise error
            main_error = cast(
                ValidationError,
                best_match(errors),  # what 'validate()' normally does using 'iter_errors()'
            )
            raise main_error
    except Exception as exc:
        test_id = conformance_test["id"]
        test_doc = conformance_test["doc"]
        raise AssertionError(
            f"Failed [{test_id}] ({instance_file}) tool validation for [{test_doc}]."
        ) from exc
