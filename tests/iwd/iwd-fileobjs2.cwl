#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
doc: Can have a file declared directly in InitialWorkDir
requirements:
  InitialWorkDirRequirement:
    listing:
      - [{class: File, location: ../loadContents/inp-filelist.txt},
         {class: Directory, location: ../testdir}]
inputs: []
outputs:
  filelist:
    type: File
    outputBinding:
      glob: inp-filelist.txt
  testdir:
    type: Directory
    outputBinding:
      glob: testdir
baseCommand: "true"
