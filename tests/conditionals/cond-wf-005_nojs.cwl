class: Workflow
cwlVersion: v1.2
inputs:
  test: boolean
  val:
    type: int
    default: 23
  def:
    type: string
    default: "Direct"

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
    type: string
    outputSource:
      - step1/out1
      - def
    pickValue: all_non_null

requirements:
  MultipleInputFeatureRequirement: {}
