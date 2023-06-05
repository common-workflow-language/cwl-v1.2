cwlVersion: v1.2
class: CommandLineTool
baseCommand: [cp, -r]
arguments:
  - position: 2
    valueFrom: $(runtime.outdir)
inputs:
  indir:
    type: Directory
    inputBinding:
      position: 1
outputs:
  result:
    type: Directory[]
    outputBinding:
      glob: $(inputs.indir.basename)/*
