#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
doc: "CommandLineTool without inputs."
hints:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim
inputs: []
outputs:
  output:
    type: File
    outputBinding: { glob: output }
baseCommand: [echo, cwl]
stdout: output
