cwlVersion: v1.2
class: CommandLineTool

requirements:
  ResourceRequirement:
    coresMax: $(inputs.threads_max)

inputs:
  threads_max:
    type: int
    default: 4

stdout: out.txt
outputs:
  out:
    type: string
    outputBinding:
      glob: out.txt
      loadContents: true
      outputEval: $(self[0].contents)

arguments: ['echo', $(runtime.cores)]
