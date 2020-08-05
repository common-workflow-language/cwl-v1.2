cwlVersion: v1.2
class: CommandLineTool
baseCommand: [echo]
inputs:
  in:
    type: string
    inputBinding:
      position: 1
  name: string?
stdout: out.txt
outputs:
  out:
    type: stdout
