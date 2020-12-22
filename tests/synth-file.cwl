cwlVersion: v1.0
class: CommandLineTool

inputs:
  names:
    type: File
    inputBinding:
      position: 1

baseCommand: [ cat ]

outputs:
  sequence:
    type: stdout
