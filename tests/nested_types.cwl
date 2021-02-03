#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

requirements:
  SchemaDefRequirement:
    types:
      - name: name
        type: record
        fields:
          - name: first
            type: string
          - name: last
            type: string
      - name: person
        type: record
        fields:
          - name: name
            type: name
          - name: age
            type: int
inputs:
  my_person: person

outputs:
  their_name: string

baseCommand: echo

stdout: cwl.output.json

arguments:
 - '{"their_name": "$(inputs.my_person.name.first) $(inputs.my_person.name.last)" }'
