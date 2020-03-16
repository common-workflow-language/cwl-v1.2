class: CommandLineTool
cwlVersion: v1.2.0-dev2
requirements:
  - class: ShellCommandRequirement
inputs:
  indir:
    type: Directory
    inputBinding:
      prefix: cd
      position: -1
outputs:
  outlist:
    type: File
    outputBinding:
      glob: output.txt
arguments: [
  {shellQuote: false, valueFrom: "&&"},
  "find", ".",
  {shellQuote: false, valueFrom: "|"},
  "sort"]
stdout: output.txt