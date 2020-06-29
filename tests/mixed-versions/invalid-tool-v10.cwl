cwlVersion: v1.0
class: CommandLineTool
inputs:
  inp1:
    type: File
    secondaryFiles:
      - pattern: ".2"
        required: true
requirements:
  ResourceRequirement:
    coresMin: .5
outputs: []
arguments: [echo, $(inputs.inp1)]
