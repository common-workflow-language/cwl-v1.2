#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
hints:
  DockerRequirement:
    dockerPull: docker.io/bash:4.4
inputs:
  input_file: File
  outdir_name: string

baseCommand: [ bash, -c ]
stdout: re:sult
arguments:
 - |
   mkdir $(inputs.outdir_name);
   cp $(inputs.input_file.path) $(inputs.outdir_name)/;
   echo Status: done!
outputs:
  log: stdout
  result:
    type: Directory
    outputBinding:
      glob: $(inputs.outdir_name)
