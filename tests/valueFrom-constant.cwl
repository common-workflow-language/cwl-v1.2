class: CommandLineTool
cwlVersion: v1.2

hints:
  - class: DockerRequirement
    dockerPull: docker.io/python:3-slim

inputs:
  - id: array_input
    type:
      - type: array
        items: File
    inputBinding:
      valueFrom: replacementValue

  - id: args.py
    type: File
    default:
      class: File
      location: args.py
    inputBinding:
      position: -1

outputs:
  - id: args
    type: string[]

baseCommand: python
