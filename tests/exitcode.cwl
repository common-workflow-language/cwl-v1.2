cwlVersion: v1.2.0-dev4
class: CommandLineTool
requirements:
  ShellCommandRequirement: {}
inputs: []
outputs:
  code:
    type: int
    outputBinding:
      outputEval: $(runtime.exitCode)
successCodes: [7]
arguments: ["exit", "7"]
