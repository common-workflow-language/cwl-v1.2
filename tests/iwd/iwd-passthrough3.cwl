#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: "renamed-filelist.txt"
        entry: $(inputs.filelist)
inputs:
  filelist:
    type: File
outputs:
  filelist:
    type: File
    outputBinding:
      glob: renamed-filelist.txt
baseCommand: "true"
