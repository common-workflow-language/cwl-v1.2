#!/usr/bin/env cwl-runner

class: ExpressionTool
requirements: { InlineJavascriptRequirement: {} }
cwlVersion: v1.2.0-dev4

inputs: []

outputs:
  output: Any

expression: "$({'output': null })"
