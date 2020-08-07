#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: "out-filelist.txt"
        entry: |-
          ${
            var ls = "";
            for (var i = 1; i < 10000; i++) {
              ls += "example_input_file"+i+".txt\n";
            }
            return ls;
          }
inputs: []
outputs:
  filelist:
    type: File
    outputBinding:
      glob: out-filelist.txt
baseCommand: "true"
