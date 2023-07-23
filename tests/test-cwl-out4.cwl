class: CommandLineTool
cwlVersion: v1.2

hints:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim

inputs: []

baseCommand: sh

arguments:
   - -c
   - |
     echo foo > foo && echo '{"foo": {"location": "foo", "class": "File"} }'

stdout: cwl.output.json

outputs:
  - id: foo
    type: File


