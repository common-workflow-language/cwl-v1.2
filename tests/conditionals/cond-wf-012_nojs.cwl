class: Workflow
cwlVersion: v1.2
inputs:
  val:
    type: int
    default: 23
  test:
    type: int
    default: 1
steps:

  step1:
    in:
      in1: val
      a_new_var: test
    run: foo.cwl
    when: $(inputs.a_new_var)
    out: [out1]

outputs:
  out1: 
    type: string?
    outputSource: step1/out1
