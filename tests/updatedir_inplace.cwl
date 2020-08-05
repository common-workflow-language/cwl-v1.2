#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
requirements:
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.r)
        entryname: inp
        writable: true
  InplaceUpdateRequirement:
    inplaceUpdate: true
inputs:
  r: Directory
outputs:
  out:
    type: Directory
    outputBinding:
      glob: inp
arguments: [touch, inp/blurb]
