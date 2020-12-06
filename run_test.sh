#!/bin/bash

func() {
	helpmessage=$(cat)
}
func <<EOF
$(basename "$0"): Run common workflow tool description language conformance tests.

Syntax:
        $(basename "$0") [RUNNER=/path/to/cwl-runner]
                       [EXTRA=--optional-arguments-to-cwl-runner]

Options:
  -nT                   Run a specific test.
  -l                    List tests
  -jJ                   Specifies the number of tests to run simultaneously
                        (defaults to one).
  --only-tools          Only test CommandLineTools
  --junit-xml=FILENAME  Store results in JUnit XML format using the given
                        FILENAME
  --classname=CLASSNAME In the JUnit XML, tag the results with the given
                        CLASSNAME
  --timeout=TIMEOUT     cwltest timeout in seconds.
  --verbose             Print the cwltest invocation and pass --verbose to
                        cwltest
  --self                Test CWL and test .cwl files themselves. If this flag
                        is given, any other flags will be ignored.
  --badgedir=DIRNAME    Specifies the directory to store JSON files for badges.
  --tags TAGS           Tags to be tested

Note:
  EXTRA is useful for passing --enable-dev to the CWL reference runner:
  Example: RUNNER=cwltool EXTRA=--enable-dev
EOF

CWL_VER=v1.2
TEST_N=""
JUNIT_XML=""
RUNNER=cwl-runner
PLATFORM=$(uname -s)
EXTRA=""
CLASS=""
VERBOSE=""
SELF=""
BADGE=""
TIMEOUT=""
TAGS=""

while [ -n "$1" ]
do
    arg="$1"; shift
    case "$arg" in
        --help)
            echo >&2 "$helpmessage"
            echo >&2
            exit 1
            ;;
        -n*)
            TEST_N=$arg
            ;;
        -j*)
            TEST_J=$arg
            ;;
        -l)
            TEST_L=-l
            ;;
        --only-tools)
            ONLY_TOOLS=$arg
            ;;
        --junit-xml=*)
            JUNIT_XML=$arg
            ;;
        --classname=*)
            CLASS=$arg
            ;;
        --verbose)
            VERBOSE=$arg
            ;;
        --self)
            SELF=1
            ;;
        --badgedir=*)
            BADGE=$arg
            ;;
        --timeout=*)
            TIMEOUT=$arg
            ;;
        --tags=*)
            TAGS=$arg
            ;;
        *=*)
            eval "$(echo "$arg" | cut -d= -f1)"=\""$(echo "$arg" | cut -d= -f2-)"\"
            ;;
    esac
done

if [ -n "${SELF}" ]; then
    # Ensure schema-salad-tool command
    if [ ! -x "$(command -v schema-salad-tool)" ]; then
        pip install --quiet schema_salad
    fi
    # This is how CWL should be written.
    DEFINITION=./CommonWorkflowLanguage.yml
    # Let's test each files
    find tests -type f -name "*.cwl" | \
        while read -r target;
        do
            schema-salad-tool ${DEFINITION} "${target}" --quiet || {
                echo "[INVALID] ${target}"
                exit 1
            }
        done
    exit 0
fi

if ! runner="$(command -v $RUNNER)" ; then
    echo >&2 "$helpmessage"
    echo >&2
    echo >&2 "runner '$RUNNER' not found"
    exit 1
fi

runs=0
failures=0

runtest() {
    echo "--- Running CWL Conformance Tests $CWL_VER on $1 ---"

    "$1" --version

    runs=$((runs+1))
    (COMMAND="cwltest --tool $1 \
         --test=conformance_tests.yaml ${CLASS} ${TEST_N} \
         ${VERBOSE} ${TEST_L} ${TEST_J} ${ONLY_TOOLS} ${JUNIT_XML} \
         ${TIMEOUT} ${BADGE} ${TAGS} -- ${EXTRA}"
     if [ "$VERBOSE" = "--verbose" ]; then echo "${COMMAND}"; fi
     ${COMMAND}
    ) || failures=$((failures+1))
}

if [ "$PLATFORM" = "Linux" ]; then
    runtest "$(readlink -f "$runner")"
else
    runtest "$(greadlink -f "$runner")"
fi

if [ -n "$TEST_L" ] ; then
   exit 0
fi

# Final reporting

echo

if [ $failures != 0 ]; then
    echo "$failures tool tests failed"
else
    if [ $runs = 0 ]; then
        echo >&2 "$helpmessage"
        echo >&2
        exit 1
    else
        echo "All tool tests succeeded"
    fi
fi

exit $failures
