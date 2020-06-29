#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2.0-dev3

requirements:
  InlineJavascriptRequirement: {}
  ResourceRequirement:
      coresMin: $(inputs.dir.listing[0].size)
      coresMax: $(inputs.dir.listing[0].size)

inputs:
  dir: Directory

outputs:
  output:
    type: stdout

baseCommand: echo

stdout: cores.txt

arguments: [ $(runtime.cores) ]
