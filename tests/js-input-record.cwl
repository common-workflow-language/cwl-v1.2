cwlVersion: v1.0

class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement

baseCommand: ['echo']

inputs:
  message:
    type:
      type: record
      name: message_object
      fields:
        text:
          type: string
          inputBinding:
            position: 1
        newlines:
          type: boolean?
          inputBinding:
            position: 0
            prefix: -n

outputs:
  out:
    type: string
    outputBinding:
      glob: output.txt
      loadContents: true
      outputEval: $(self[0].contents)
stdout: output.txt
