#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.2

requirements:
  MultipleInputFeatureRequirement: {}
  InlineJavascriptRequirement: {}
  StepInputExpressionRequirement: {}
  ScatterFeatureRequirement: {}

inputs:
    forward_reads: File?
    reverse_reads: File?
    single_reads: File?

outputs:
  out_file:
    type: File[]
    outputSource:
      - step_paired/processed_file
      - step_single/processed_file
    linkMerge: merge_flattened
    pickValue: all_non_null

steps:

  step_paired:
    run: action.cwl
    when: $(inputs.single === null)
    scatter: [initial_file, suffix]
    scatterMethod: dotproduct
    in:
      single: single_reads
      suffix:
        default: ["1", "2"]
      initial_file:
        - forward_reads
        - reverse_reads
      out_file_name: { valueFrom: "filename_paired$(inputs.suffix)" }
    out: [ processed_file ]

  step_single:
    run: action.cwl
    when: $(inputs.single !== null)
    in:
      single: single_reads
      initial_file: single_reads
      out_file_name: { default: 'filename_single' }
    out: [ processed_file ]
