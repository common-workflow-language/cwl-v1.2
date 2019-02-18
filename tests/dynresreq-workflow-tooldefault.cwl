#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.1.0-dev1

inputs:
  special_file: File?
outputs:
  cores:
    type: File
    outputSource: report/output

steps:
  count:
    in:
      special_file: special_file
    out: [output]
    run: dynresreq-default.cwl

  report:
    in:
      file1: count/output
    out: [output]
    run: cat-tool.cwl