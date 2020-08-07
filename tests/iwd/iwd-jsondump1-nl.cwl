#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: "out-filelist.json"
        entry: |
          ${
            var ls = [];
            for (var i = 1; i < 10000; i++) {
              ls.push("example_input_file"+i+".txt");
            }
            return ls;
          }
inputs: []
outputs:
  filelist:
    type: File
    outputBinding:
      glob: out-filelist.json
arguments: ["true"]
