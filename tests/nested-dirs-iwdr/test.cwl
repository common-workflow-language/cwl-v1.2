#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

# Test that nested directories, InitialWorkDirRequirement, containers
# work correctly together. This is based on a reported problem, see
# https://github.com/common-workflow-language/common-workflow-language/issues/749

requirements:
  - class: SubworkflowFeatureRequirement

inputs: []

steps:
  directory_output_step:
    run: mkdir.cwl
    in: []
    out: [my_output]

  initial_work_dir_step:
    run: initial_work_dir.cwl
    in:
        my_input: directory_output_step/my_output
    out: [my_output]
 
outputs:
  final_output:
    type: Directory
    outputSource: initial_work_dir_step/my_output
