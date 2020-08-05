class: Workflow
cwlVersion: v1.2
inputs:
  in1: int[]
  in2: int[]
  in3: int[]

steps:

  step1:
    in:
      in1: in1
      in2: in2
      in3: in3
    run: cat.cwl
    when: $(inputs.in3 % 2 == 0)
    out: [out1]
    scatter: [in1, in2, in3]
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
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
