cwlVersion: v1.0
class: Workflow

doc: reproduces https://github.com/DataBiosphere/toil/issues/3141

requirements:
  StepInputExpressionRequirement: {}

inputs:
  input_bool:
    type: boolean
    default: False

outputs:
  out:
    type: File
    outputSource: echo/out

steps:
  echo:
    run:
      cwlVersion: v1.0
      class: CommandLineTool
      baseCommand: echo
      inputs:
        str:
          type: string
          default: "UNDEFINED"
          inputBinding:
            position: 1
      outputs:
        out: stdout
      stdout: file.txt
    in:
      str:
        source: input_bool
        valueFrom: self is $(self)
    out:
      - out
