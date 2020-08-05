class: CommandLineTool
cwlVersion: v1.2
inputs: []
outputs: []
requirements:
  ToolTimeLimit:
    timelimit: 3
  WorkReuse:
    enableReuse: false
baseCommand: [sleep, "15"]
