class: CommandLineTool
cwlVersion: v1.2.0-dev5
inputs:
  in1: int
baseCommand: [echo]
outputs:
  out1:
    type: string
    outputBinding:
      outputEval: foo $(inputs.in1)
