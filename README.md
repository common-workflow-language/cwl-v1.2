# Common Workflow Language Specifications, v1.1.0-dev1

The CWL specifications are divided up into several documents.

The [User Guide](http://www.commonwl.org/user_guide/) provides a gentle
introduction to writing CWL command line tools and workflows.

The [Command Line Tool Description Specification](CommandLineTool.html)
specifies the document schema and execution semantics for wrapping and
executing command line tools.

The [Workflow Description Specification](Workflow.html) specifies the document
schema and execution semantics for composing workflows from components such as
command line tools and other workflows.

The
[Semantic Annotations for Linked Avro Data (SALAD) Specification](SchemaSalad.html)
specifies the preprocessing steps that must be applied when loading CWL
documents and the schema language used to write the above specifications.

Inheritance graphs (as SVG images) for the [Schema Salad object model](salad.svg) and the [CWL object model](cwl.svg).

# Running the conformance tests

Install a CWL runner of your choice. The reference runner can be installed as
the default runner by doing:
```
pip install cwlref-runner
```

Install the test runner:

```
pip install cwltest
```

From within the repository (e.g. cwl-v1.1) execute the main test script
```
./run_test.sh
```

For details of options you can pass to the test script, do:
```
./run_test.sh --help
```

The full test suite takes about 10 min to run