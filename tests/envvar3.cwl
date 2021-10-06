#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
inputs: []
outputs:
  results:
    type: File
    outputBinding: { glob: results }
requirements:
  ShellCommandRequirement: {}
hints:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim
arguments:
  - shellQuote: false
    valueFrom: |
      echo HOME=$HOME TMPDIR=$TMPDIR > log
      if [ "$HOME" = "$(runtime.outdir)" ] && [ "$TMPDIR" = "$(runtime.tmpdir)" ]
      then
          echo success > results
      else
          echo failure > results
      fi
