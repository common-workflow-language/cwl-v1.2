#!/usr/bin/env cwl-runner

cwlVersion: v1.2.0-dev3

requirements:
  - class: DockerRequirement
    dockerPull: debian:stretch-slim

class: CommandLineTool

inputs: []

outputs:
  - id: OUTPUT
    type: File
    outputBinding:
      glob: /etc/passwd

baseCommand: [echo]
