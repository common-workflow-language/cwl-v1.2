cwlVersion: v1.2
class: Workflow

requirements:
  - class: MultipleInputFeatureRequirement

inputs: []

steps:
  step1:
    run: echo-tool.cwl
    in:
      in:
        default: hello
    out: [out]
  step2:
    run: echo-tool.cwl
    in:
      in:
        default: world
    out: [out]

outputs:
  hello_world_in_two_lines:
    type:
      type: array
      items: string
    # Only allowed with MultipleInputFeatureRequirement
    outputSource: [step1/out, step2/out]
