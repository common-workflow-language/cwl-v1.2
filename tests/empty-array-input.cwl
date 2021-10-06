#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

hints:
  - class: DockerRequirement
    dockerPull: docker.io/python:3-slim

inputs:
  - id: array
    type: { type: array, items: int }
    inputBinding:
      position: 1
      prefix: -I
      itemSeparator: ","

  - id: args.py
    type: File
    default:
      class: File
      location: args.py
    inputBinding:
      position: -1

outputs:
  - id: args
    type:
      type: array
      items: string

baseCommand: python
