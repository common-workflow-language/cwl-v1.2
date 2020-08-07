#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
doc: |
  YAML | syntax adds a trailing newline, so in the listing entry
  below, it becomes a string interpolation -- it evaluates to a string
  consisting of $(inputs.filelist) serialized to JSON and then adding
  a newline.  Compare to iwd-passthrough1.cwl

requirements:
  DockerRequirement:
    dockerPull: "python:3-slim"
  InitialWorkDirRequirement:
    listing:
      - entryname: "renamed-filelist.txt"
        entry: |
          $(inputs.filelist)
inputs:
  filelist: File
  script:
    type: File
    default:
      class: File
      location: loadit.py
stdout: out.txt
outputs:
  out: stdout
arguments: [python3, $(inputs.script), "renamed-filelist.txt"]
