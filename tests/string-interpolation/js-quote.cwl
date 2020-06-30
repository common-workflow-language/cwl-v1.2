#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0
label: Does cwltool have a JS quoting bug?

requirements:
  InitialWorkDirRequirement:
    listing:
    - entryname: file.txt
      entry: |
        ${return 'quote "' + inputs.quote + '"'}
    - entryname: script.sh
      entry: |
        set -xe
        cat file.txt
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    coresMin: 2
    ramMin: 1000

inputs:
  quote:
    type: string
    default: Hello

outputs:
  out:
    type: File
    outputBinding:
      glob: file.txt

baseCommand:
- echo
arguments: []
