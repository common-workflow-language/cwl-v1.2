cwlVersion: v1.2
class: Workflow
doc: |
  Workflow that includes tools that are marked as v1.0 and v1.1 that
  contain v1.2 features.  Should fail.
requirements:
  InlineJavascriptRequirement: {}
inputs:
  inp1:
    type: File
    default:
      class: File
      location: hello.txt
    secondaryFiles:
      - pattern: ".2"
        required: true
outputs: []
steps:
  toolv10:
    in: {inp1: inp1}
    out: []
    run: invalid-tool-v10.cwl
  toolv11:
    in: {inp1: inp1}
    out: []
    run: invalid-tool-v11.cwl
  toolv12:
    in: {inp1: inp1}
    out: []
    when: $(true)
    run: tool-v12.cwl
