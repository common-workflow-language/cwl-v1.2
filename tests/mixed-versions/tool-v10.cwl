cwlVersion: v1.0
class: CommandLineTool
inputs:
  inp1:
    type: File
    secondaryFiles:
      - ".2"
outputs: []
arguments: [echo, $(inputs.inp1)]
