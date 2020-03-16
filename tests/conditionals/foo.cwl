class: CommandLineTool
cwlVersion: v1.2.0-dev2
inputs:
  in1: int
baseCommand: [echo]
outputs:
  out1:
    type: string
    outputBinding:
      outputEval: ${return "foo " + inputs.in1}

requirements:
  InlineJavascriptRequirement: {}
