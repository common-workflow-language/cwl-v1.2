#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
doc: "Create a file under adir/, symlink it to working directory (./) and glob symlink. The executor should resolve this symlink"
hints:
  DockerRequirement:
    dockerPull: docker.io/alpine:latest
inputs: []
outputs:
  output_file:
    type: File
    outputBinding: {glob: symlink.txt}

requirements:
  - class: ShellCommandRequirement

arguments:
  - mkdir
  - adir
  - {valueFrom: " && ", shellQuote: false}
  - echo
  - "Who's gonna drive you home"
  - {valueFrom: "> adir/original.txt", shellQuote: false}
  - {valueFrom: " && ", shellQuote: false}
  - ln
  - -s
  - adir/original.txt
  - symlink.txt
