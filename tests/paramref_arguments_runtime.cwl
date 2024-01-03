#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

baseCommand: echo

inputs: []

arguments:
 - '{"runtime":$(runtime)}'

stdout: cwl.output.json

outputs:
  runtime:
    type:
      type: record
      fields:
        cores: long
        outdir: string
        outdirSize: long
        ram: long
        tmpdir: string
        tmpdirSize: long      
