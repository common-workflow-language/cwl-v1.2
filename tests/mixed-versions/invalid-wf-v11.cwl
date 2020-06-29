cwlVersion: v1.1
class: Workflow
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
    run: tool-v10.cwl
  toolv11:
    in: {inp1: inp1}
    out: []
    run: tool-v11.cwl
  toolv12:
    in: {inp1: inp1}
    out: []
    when: $(true)
    run: tool-v12.cwl
