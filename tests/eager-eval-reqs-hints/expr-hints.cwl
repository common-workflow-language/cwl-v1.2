cwlVersion: v1.2
class: ExpressionTool

requirements:
  InlineJavascriptRequirement: {}

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads_max)

inputs:
  threads_max:
    type: int
    default: 4

outputs:
  out: string

expression: |
  ${ return {"out": runtime.cores }}
