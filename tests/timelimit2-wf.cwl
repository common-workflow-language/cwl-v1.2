#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.2

doc: |
  The entire test should take ~24 seconds.  Test that the 20 second
  time limit applies to each step individually (so 1st step has 20
  seconds and the 2nd step has 20 seconds).  So this 20 second time
  limit should not cause the workflow to fail.

  The timing on this test was updated from shorter values to
  accommodate the startup time of certain container runners, the
  previous timelimit of 5 seconds was too short, which is why it is
  now 20 seconds.

requirements:
  ToolTimeLimit:
    timelimit: 20
  InlineJavascriptRequirement: {}

inputs:
  i:
    type: string?

outputs:
  o:
    type: string?
    outputSource: step2/o

steps:
  step1:
    in:
      i: i
    out: [o]
    run:
      class: CommandLineTool
      baseCommand: ["sleep", "12"]
      inputs:
        i:
          type: string?
      outputs:
        o:
          type: string?
          outputBinding:
            outputEval: $("time passed")
  step2:
    in:
      i: step1/o
    out: [o]
    run:
      class: CommandLineTool
      baseCommand: ["sleep", "12"]
      inputs:
        i:
          type: string?
      outputs:
        o:
          type: string?
          outputBinding:
            outputEval: $("time passed")
