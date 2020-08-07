class: Workflow
cwlVersion: v1.2
inputs:
  data:
    type: int[]
    default: [1, 2, 3, 4, 5, 6]
  test: boolean

steps:

  step1:
    in:
      in1: data
      a_new_var: test
    run: foo.cwl
    when: $(inputs.a_new_var)
    out: [out1]
    scatter: in1

outputs:
  out1:
    type: string[]
    outputSource: step1/out1
    pickValue: all_non_null

requirements:
  ScatterFeatureRequirement: {}
