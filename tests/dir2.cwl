class: CommandLineTool
cwlVersion: v1.2
requirements:
  ShellCommandRequirement: {}
hints:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim
inputs:
  indir: Directory
outputs:
  outlist:
    type: File
    outputBinding:
      glob: output.txt
arguments: ["cd", "$(inputs.indir.path)",
  {shellQuote: false, valueFrom: "&&"},
  "find", ".",
  {shellQuote: false, valueFrom: "|"},
  "sort"]
stdout: output.txt
