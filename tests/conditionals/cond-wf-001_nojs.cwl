class: Workflow
cwlVersion: v1.2
inputs:
  test: boolean

steps:

  step1:
    in:
      in1:
        default: 23
      extra: test
    run: foo.cwl
    when: $(inputs.extra)
    out: [out1]

outputs:
  out1: 
    type: string?
    outputSource: step1/out1
