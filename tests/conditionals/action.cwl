#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
inputs:
  initial_file: File
  out_file_name: string
outputs:
  processed_file: stdout
stdout: $(inputs.out_file_name)
arguments: [echo, $(inputs.initial_file.basename)]
