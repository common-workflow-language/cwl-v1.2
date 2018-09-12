#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
id: stage_array
baseCommand:
  - cat
inputs:
  - id: input_file
    type: File
  - id: optional_file
    type: File?
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
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_file)
      - ${ if (inputs.optional_file) return inputs.optional_file; else return null}
      - entry: $(inputs.input_list)
      - entryname: a
        entry: b
  - class: InlineJavascriptRequirement