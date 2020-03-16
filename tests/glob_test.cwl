#!/usr/bin/env cwl-runner
cwlVersion: v1.2.0-dev2
class: CommandLineTool

inputs: []
baseCommand: [touch, z, y, x, w, c, b, a]
outputs:
  letters:
    type: File[]
    outputBinding: { glob: '*' }
