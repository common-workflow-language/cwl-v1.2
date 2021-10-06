class: CommandLineTool
cwlVersion: v1.2
inputs: []
outputs: []
requirements:
  ShellCommandRequirement: {}
hints:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim
arguments: [
  echo, {valueFrom: '"HOME=$HOME"', shellQuote: false}, {valueFrom: '"TMPDIR=$TMPDIR"', shellQuote: false},
  {valueFrom: '&&', shellQuote: false},
  test, {valueFrom: '"$HOME"', shellQuote: false}, "=", $(runtime.outdir),
  "-a", {valueFrom: '"$TMPDIR"', shellQuote: false}, "=", $(runtime.tmpdir)]
