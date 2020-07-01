class: CommandLineTool
cwlVersion: v1.2.0-dev4
requirements:
  - class: InlineJavascriptRequirement  # needed by params_inc.yml

inputs:
  bar:
    type: Any
    default: {
          "baz": "zab1",
          "b az": 2,
          "b'az": true,
          'b"az': null,
          "buz": ['a', 'b', 'c']
        }

outputs: {"$import": params_inc.yml}

baseCommand: "true"
