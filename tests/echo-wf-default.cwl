
class: Workflow
cwlVersion: v1.2.0-dev3

inputs: []

steps:
  step1:
    run: echo-tool-default.cwl
    in:
      in: 
        default: workflow_default
    out: [out]
    
outputs:
    default_output:
      type: string
      outputSource: step1/out

