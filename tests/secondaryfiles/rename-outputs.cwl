#!/usr/bin/env cwl-runner
id: OutputSecondaryFileConformanceTest
baseCommand:
- ls
class: CommandLineTool
cwlVersion: v1.2
doc: |
  Simple test to confirm the implementation of expressions returning a File within a CommandOutputParameter.secondaryFile field.

  Related links:
  - Issue: https://github.com/common-workflow-language/cwltool/issues/1232
  - PR: https://github.com/common-workflow-language/cwltool/pull/1233
  - Discourse: https://cwl.discourse.group/t/ask-cwl-to-rename-a-secondary-file/72

inputs: []
outputs:
- id: output_file
  label: out
  outputBinding:
    glob: "*.txt"
  secondaryFiles: |
   ${
        function resolveSecondary(base, secPattern) {
          if (secPattern[0] == "^") {
            var spl = base.split(".");
            var endIndex = spl.length > 1 ? spl.length - 1 : 1;
            return resolveSecondary(spl.slice(undefined, endIndex).join("."), secPattern.slice(1));
          }
          return base + secPattern;
        }
        return [
          {
            "class": "File",
            "path": resolveSecondary(self.path, "^.accessory"),
            "basename": resolveSecondary(self.basename, ".accessory")
          }
        ];
   }
  type: File
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
    - entry: ""
      entryname: secondary_file_test.txt
      writable: true
    - entry: ""
      entryname: secondary_file_test.accessory
      writable: true
