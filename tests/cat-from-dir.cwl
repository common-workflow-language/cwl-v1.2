#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.2.0-dev3

inputs:
  dir1: Directory

outputs:
  output:
    type: stdout

baseCommand: [cat]

stdin: $(inputs.dir1.listing[0].path)
