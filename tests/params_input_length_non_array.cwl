class: CommandLineTool
cwlVersion: v1.2
inputs:
  length:
    type: int
    default: 1
  bar:
    type:
      type: record
      name: bar_record
      fields:
        length:
          type: int
  baz:
    type:
      type: record
      name: baz_record
      fields:
        length:
          type:
            type: record
            name: length_record
            fields:
              bap:
                type: int

outputs:
  output1:
    type: int
    outputBinding:
      outputEval: $(inputs.length)
  output2:
    type: int
    outputBinding:
      outputEval: $(inputs.bar.length)
  output3:
    type: int
    outputBinding:
      outputEval: $(inputs.baz.length.bap)
baseCommand: "true"