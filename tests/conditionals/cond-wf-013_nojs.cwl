class: Workflow
cwlVersion: v1.2
inputs:
  in1:
    type: int[]
    default: [1, 2, 3, 4, 5, 6]
  test1:
    type: boolean[]
    default: [false, true, false, true, false, true]
  test2:
    type: boolean[]
    default: [true, false, true, false, true, false]

steps:

  step1:
    in:
      in1: in1
      another_var: test1
    run: foo.cwl
    when: $(inputs.another_var)
    out: [out1]
    scatter: [ in1, another_var ]
    scatterMethod: dotproduct

  step2:
    in:
      in1: in1
      another_var: test2
    run: bar.cwl
    when: $(inputs.another_var)
    out: [out1]
    scatter: [ in1, another_var ]
    scatterMethod: dotproduct

outputs:
  out1:
    type: string[]
    outputSource:
      - step1/out1
      - step2/out1
    linkMerge: merge_flattened
    pickValue: all_non_null

requirements:
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
