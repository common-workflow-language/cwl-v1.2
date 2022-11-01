#!/usr/bin/env cwl-runner
# See https://github.com/jeremiahsavage/cwl_schemadef/, thanks to Jeremiah H. Savage.
cwlVersion: v1.2
class: Workflow

requirements:
  - class: SchemaDefRequirement
    types:
      - $import: schemadef_types_with_import_readgroup.yml

inputs:
  readgroups_bam:
    type: "schemadef_types_with_import_readgroup.yml#readgroups_bam_file"

steps:
  step1:
    run: schemadef_types_with_import-tool.cwl
    in:
      message: readgroups_bam
    out: [out]

outputs:
  out:
    type: string
    outputSource: step1/out
