class: CommandLineTool
cwlVersion: v1.2
doc: Given a directory, emit it unchanged
requirements:
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.testdir)
        writable: false
inputs:
  testdir:
    type: Directory
outputs:
  testdir:
    type: Directory
    outputBinding:
      glob: $(inputs.testdir.basename)
baseCommand: "true"
