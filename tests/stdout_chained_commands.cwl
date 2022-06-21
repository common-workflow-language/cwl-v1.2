cwlVersion: v1.2
class: CommandLineTool
requirements:
  - class: ShellCommandRequirement
inputs: []
outputs:
  out:
    type: string
    outputBinding:
      glob: out.txt
      loadContents: true
      outputEval: $(self[0].contents)
stdout: out.txt
arguments:
  - echo
  - a
  - {valueFrom: '&&', shellQuote: false}
  - echo
  - b
