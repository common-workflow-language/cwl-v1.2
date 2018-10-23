#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.1.0-dev1
doc: "Create a file under /tmp, symlink it to working directory and glob symlink"
hints:
  DockerRequirement:
    dockerPull: alpine
inputs: []
outputs:
  output_file:
    type: File
    outputBinding: {glob: symlink.txt}
baseCommand:
  - echo "Who's gonna drive you home" > /tmp/original.txt
  - ln -s /tmp/original.txt symlink.txt