#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
id: stage_array_dirs
baseCommand:
  - ls
inputs:
  - id: input_list
    type: Directory[]
stdout: out.tar
outputs:
  - id: output
    type: File[]
    outputBinding:
      glob: 
      - testdir/a
      - rec/A
label: stage-array.cwl
requirements:
  - class: DockerRequirement
    dockerPull: 'ubuntu:16.04'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_list)
  - class: InlineJavascriptRequirement