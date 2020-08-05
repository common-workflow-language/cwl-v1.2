class: Workflow
cwlVersion: v1.2
inputs:
  data: int[]
  val: int

steps:

  step1:
    in:
      in1: data
      a_new_var: val
    run: foo.cwl
    when: $(inputs.a_new_var > 3)
    out: [out1]
    scatter: in1

outputs:
  out1:
    type: string[]
    outputSource: step1/out1
    pickValue: all_non_null

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
