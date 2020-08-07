class: Workflow
cwlVersion: v1.2
inputs:
  in1: int[]

steps:

  step1:
    in:
      in1: in1
    run: foo.cwl
    when: $(inputs.in1 % 2 == 0)
    out: [out1]
    scatter: in1

  step2:
    in:
      in1: in1
    run: bar.cwl
    when: $(inputs.in1 % 2 == 1)
    out: [out1]
    scatter: in1

outputs:
  out1:
    type: string[]
    outputSource:
      - step1/out1
      - step2/out1
    linkMerge: merge_flattened
    pickValue: all_non_null

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
