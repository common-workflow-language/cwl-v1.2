#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2.0-dev2
doc: "CommandLineTool without inputs."
hints:
  DockerRequirement:
    dockerPull: debian:stretch-slim
inputs: []
outputs:
  output:
    type: File
    outputBinding: { glob: output }
baseCommand: [echo, cwl]
stdout: output
