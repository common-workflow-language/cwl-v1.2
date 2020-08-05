cwlVersion: v1.2
class: CommandLineTool
inputs:
  scattered_message:
    type: string
    inputBinding:
      position: 2
  message:
    type: string
    inputBinding:
      position: 1
outputs:
  out_message:
    type: stdout
baseCommand: echo
