class: ExpressionTool
cwlVersion: v1.2.0-dev4
requirements:
  InlineJavascriptRequirement: {}
inputs: []
outputs:
  lit: File
expression: |
  ${
  return {"lit": {"class": "File", "basename": "a_file", "contents": "Hello file literal."}};
  }