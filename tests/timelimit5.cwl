class: ExpressionTool
cwlVersion: v1.1.0-dev1
inputs: []
outputs:
  status: string
requirements:
  ToolTimeLimit:
    timelimit: 3
  InlineJavascriptRequirement: {}
expression: "${\n    function sleep(milliseconds) {\n      var start = new Date().getTime();\n      for (var i = 0; i < 1e7; i++) {\n        if ((new Date().getTime() - start) > milliseconds){\n          break;\n        }\n      }\n    };\n    sleep(5000);\n    return {\"status\": \"Done\"}\n}"
