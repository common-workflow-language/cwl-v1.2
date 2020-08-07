#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.2

inputs:
    file1: File

outputs:
    count_output:
      type: int
      outputSource: step1/output

steps:
  step1:
    run: wc2-tool.cwl
    in:
      file1:
        source: [file1]
    out: [output]
