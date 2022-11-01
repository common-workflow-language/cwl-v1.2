cwlVersion: v1.2
class: CommandLineTool
inputs:
  ref:
    type:
      type: record
      fields:
        genome_fa: string
        annotation_gtf: string
    default: { genome_fa: GRCm38.primary_assembly.genome.fa,
               annotation_gtf: gencode.vM21.primary_assembly.annotation.gtf }

baseCommand: echo
arguments:
 - $(inputs.ref.genome_fa) $(inputs.ref.annotation_gtf)
outputs:
  references:
    type:
      type: record
      fields:
        genome_fa: string
        annotation_gtf: string
    outputBinding:
        outputEval: $(inputs.ref)
  summary:
    type: stdout
