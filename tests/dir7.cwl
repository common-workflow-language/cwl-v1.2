class: ExpressionTool
cwlVersion: v1.2.0-dev3
requirements:
  InlineJavascriptRequirement: {}
inputs:
  files: File[]
outputs:
  dir: Directory
expression: |
  ${
  return {"dir": {"class": "Directory", "basename": "a_directory", "listing": inputs.files}};
  }