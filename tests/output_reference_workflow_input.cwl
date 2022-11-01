cwlVersion: v1.2
class: Workflow

inputs:
  first:
    type: string
    default: me

steps: []

outputs:
  last:
   type: string
   outputSource: first
