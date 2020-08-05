class: Workflow
cwlVersion: v1.2
inputs:
  val:
    type: int
    default: 23
  test1: boolean
  test2: boolean

steps:

  step1:
    in:
      in1: val
      a_new_var: test1
    run: foo.cwl
    when: $(inputs.a_new_var)
    out: [out1]

  step2:
    in:
      in1: val
      a_new_var: test2
    run: foo.cwl
    when: $(inputs.a_new_var)
    out: [out1]

outputs:
  out1:
    type: string
    outputSource:
      - step1/out1
      - step2/out1
    pickValue: first_non_null

requirements:
  MultipleInputFeatureRequirement: {}
