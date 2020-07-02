#!/usr/bin/env cwl-runner

cwlVersion: v1.2.0-dev4
class: ExpressionTool

requirements:
  InlineJavascriptRequirement: {}

inputs:
  i:
    type: int

outputs:
  o:
    type: int[]

expression: >
  ${return {'o': Array.apply(null, {length: inputs.i}).map(Number.call, Number)};}
