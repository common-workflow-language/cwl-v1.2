class: Workflow
cwlVersion: v1.2.0-dev2
inputs:
  val: int
  def:
    type: string
    default: "Direct"

steps:

  step1:
    in:
      in1: val
      a_new_var: val
    run: foo.cwl
    when: $(inputs.a_new_var > 2)
    out: [out1]

outputs:
  out1:
    type: string
    outputSource:
      - step1/out1
      - def
    pickValue: the_only_non_null

requirements:
  InlineJavascriptRequirement: {}
  MultipleInputFeatureRequirement: {}
