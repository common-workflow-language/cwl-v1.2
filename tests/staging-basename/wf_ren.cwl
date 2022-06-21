class: Workflow
cwlVersion: v1.2
inputs:
  f1:
    type: File
    default:
      class: File
      location: whale.txt
  newname:
    type: string
    default:  "badger.txt"
outputs: []
requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
steps:
  rename:
    in:
      f1: f1
      newname: newname
    run: rename.cwl
    out: [out]

  echo:
    in:
      p: rename/out
      checkname: newname
    out: []
    run: check.cwl
