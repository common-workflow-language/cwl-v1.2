#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.1.0-dev1

requirements:
  TimeLimit:
    timelimit: -1

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
      baseCommand: ["sleep", "10"]
      inputs:
        i:
          type: int?
      outputs:
        o:
          type: string?
          outputBinding:
            outputEval: "time passed"
      
