class: CommandLineTool
cwlVersion: v1.2
requirements:
  DockerRequirement:
    dockerPull: docker.io/bash:4.4
inputs: []
outputs:
  cow:
    type: File
    outputBinding:
      glob: cow
baseCommand: ["-c", "echo 'moo' > cow"]
