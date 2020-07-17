class: CommandLineTool
cwlVersion: v1.2.0-dev4

requirements:
  DockerRequirement:
      dockerPull: debian:stable-slim
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing: |
      ${
         return [{"class": "Directory",
                  "basename": "subdir",
                  "listing": [ inputs.filelist ]
                  }]}

inputs:
  filelist: File

outputs:
  same:
   type: File
   outputBinding:
     glob: subdir/$(inputs.filelist.basename)
