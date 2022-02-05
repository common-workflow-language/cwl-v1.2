class: CommandLineTool
cwlVersion: v1.2
requirements:
  - class: ShellCommandRequirement
hints:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim

inputs: []

outputs:
  - id: foo
    type: File

arguments:
   - valueFrom: >
       echo foo > foo && echo '{"foo": {"path": "$(runtime.outdir)/foo", "class": "File"} }' > cwl.output.json
     shellQuote: false
