class: CommandLineTool
cwlVersion: v1.2
inputs:
  in1: int
  in2: int
  in3: int
baseCommand: [echo]
outputs:
  out1:
    type: string
    outputBinding:
      outputEval: $(inputs.in1)$(inputs.in2)$(inputs.in3)
