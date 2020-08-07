class: CommandLineTool
cwlVersion: v1.2
inputs:
  in: string
outputs:
  out:
    type: string
    outputBinding:
      glob: out.txt
      loadContents: true
      outputEval: $(self[0].contents)
stdout: out.txt
arguments: [echo, $(inputs.in), $(inputs.in2)]
