#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.2

requirements:
  ToolTimeLimit:
    timelimit: 8

inputs:
  i:
    type: int?

outputs:
  o:
    type: string?
    outputSource: step1/o

steps:
  step1:
    in:
      i: i
    out: [o]
    run:
      class: CommandLineTool
      baseCommand: ["sleep", "16"]
      inputs:
        i:
          type: int?
      outputs:
        o:
          type: string?
          outputBinding:
            outputEval: $(runtime.outdir)
