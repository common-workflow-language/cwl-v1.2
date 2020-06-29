cwlVersion: v1.1
class: CommandLineTool
inputs:
  inp1:
    type: File
    secondaryFiles:
      - pattern: ".2"
        required: true
outputs: []
arguments: [echo, $(inputs.inp1)]
