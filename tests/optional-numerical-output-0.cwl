cwlVersion: v1.1
class: CommandLineTool
baseCommand:
  - echo
  - "0"
stdout: a.txt
requirements:
- class: InlineJavascriptRequirement
inputs: []
outputs:
  out:
    type: float?
    outputBinding:
      glob: "a.txt"
      loadContents: true
      outputEval: "${\n    return parseFloat(self[0].contents);\n}"