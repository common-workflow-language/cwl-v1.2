#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2.0-dev5
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.filelist)
inputs:
  filelist:
    type: File
outputs:
  filelist:
    type: File
    outputBinding:
      glob: $(inputs.filelist.basename)
baseCommand: "true"
