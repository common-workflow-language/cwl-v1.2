#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
id: stage_array
baseCommand:
  - cat
inputs:
  - id: input_file
    type: File
  - id: input_list
    type: 'File[]'
    inputBinding:
      position: 1
      valueFrom: '$(self[0].nameroot).tar'
    secondaryFiles:
      - ^.tar
stdout: out.tar
outputs:
  - id: output
    type: File?
    outputBinding:
      glob: out.tar
label: stage-array.cwl
requirements:
  - class: DockerRequirement
    dockerPull: 'ubuntu:16.04'
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_file)
      - $(inputs.input_list)
      - entryname: a
        entry: b
  - class: InlineJavascriptRequirement