#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
hints:
  - class: DockerRequirement
    dockerPull: docker.io/python:3-slim
inputs:
- id: flag
  type: boolean
  inputBinding: {}
- id: "args.py"
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
arguments: []
