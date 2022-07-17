#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim

inputs:
  name:
    type: string
    inputBinding:
      position: 0

outputs:
  empty_file:
    type: File
    outputBinding:
      glob: $(inputs.name)
      
baseCommand: [touch]
