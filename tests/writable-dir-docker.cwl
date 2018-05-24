cwlVersion: v1.1.0-dev1

class: CommandLineTool

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: emptyWritableDir
        entry: "$({class: 'Directory', listing: []})"
        writable: true

hints:
  - class: DockerRequirement
    dockerPull: alpine

inputs: []
outputs:
  out:
    type: Directory
    outputBinding:
      glob: emptyWritableDir
arguments: [touch, emptyWritableDir/blurg]
