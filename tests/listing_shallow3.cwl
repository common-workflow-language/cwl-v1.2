#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2
requirements:
  InlineJavascriptRequirement: {}
inputs: []
outputs:
  out:
    type: File
    outputBinding:
      glob: "."
      loadListing: shallow_listing
      outputEval: |-
        ${
          for (var i = 0; i < self[0].listing.length; i++) {
            if (self[0].listing[i].basename == "file2") {
              return self[0].listing[i];
            }
          }
        }
arguments: ["touch", "file1", "file2", "file3"]
