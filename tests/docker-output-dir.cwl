class: CommandLineTool
cwlVersion: v1.2
requirements:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim
    dockerOutputDirectory: /other
inputs: []
outputs:
  thing:
    type: File
    outputBinding:
      glob: thing
baseCommand: ["touch", "/other/thing"]
