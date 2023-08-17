#!/usr/bin/env cwl-runner
cwlVersion: v1.2

class: CommandLineTool

baseCommand: echo

inputs: []

arguments:
 - '{"self":$(self)}'

stdout: cwl.output.json

outputs:
  self: Any?
