#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.my_input)
        writable: False

baseCommand: 'true'

inputs:
  my_input:
    type: Directory
    inputBinding:
      position: 1

outputs:
  my_output:
    type: Directory
    outputBinding:
      glob: $(inputs.my_input.basename)
