cwlVersion: v1.2
class: Workflow

hints:
  ResourceRequirement:
    coresMax: $(inputs.threads_max)

inputs:
  threads_max:
    type: int
    default: 4

steps:
  one:
    in: []
    run:
      class: CommandLineTool
      inputs:
        other_input:
          type: int
          default: 8
      baseCommand: echo
      arguments: [ $(runtime.cores) ]
      stdout: out.txt
      outputs:
        out:
          type: string
          outputBinding:
            glob: out.txt
            loadContents: true
            outputEval: $(self[0].contents)
    out: [out]

outputs:
  out:
    type: string
    outputSource: one/out

