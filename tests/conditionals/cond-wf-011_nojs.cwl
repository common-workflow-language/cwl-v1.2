class: Workflow
cwlVersion: v1.2
inputs:
  in1:
    type: int[]
    default: [1, 2]
  in2:
    type: int[]
    default: [1, 2, 3]
  in3:
    type: int
    default: 23
  test:
    type: boolean[]
    default: [false, true, false, true]

steps:

  step1:
    in:
      in1: in1
      in2: in2
      in3: in3
      another_input: test
    run: cat.cwl
    when: $(inputs.another_input)
    out: [out1]
    scatter: [in1, in2, another_input]
    scatterMethod: nested_crossproduct
    
outputs:
  out1:
    type: 
      type: array
      items: 
        type: array
        items:
          type: array
          items: string
    outputSource: step1/out1
    pickValue: all_non_null

requirements:
  ScatterFeatureRequirement: {}
