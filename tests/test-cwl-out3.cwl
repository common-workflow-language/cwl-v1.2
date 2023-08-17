class: CommandLineTool
cwlVersion: v1.2
hints:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim

baseCommand: sh

inputs: []

outputs:
  - id: foo
    type: File

stdout: cwl.output.json

arguments:
   - -c
   - |
     echo foo > foo && echo '{"foo": {"path": "foo", "class": "File"} }'
