#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: docker.io/python:3-slim

inputs:
  dir_with_executable_file: Directory

baseCommand: []

arguments:
 - $(inputs.dir_with_executable_file.path)/args.py
 - "1"
 - two
 - "3"

outputs:
  args: string[]
