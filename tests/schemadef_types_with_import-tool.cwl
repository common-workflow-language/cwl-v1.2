#!/usr/bin/env cwl-runner
class: CommandLineTool
cwlVersion: v1.2

requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - $import: schemadef_types_with_import_readgroup.yml

inputs:
    - id: message
      type: "schemadef_types_with_import_readgroup.yml#readgroups_bam_file"
      inputBinding:
        valueFrom: $(self.readgroup_meta_list[0]['DT'])

outputs:
    - id: out
      type: string
      outputBinding:
        glob: output.txt
        loadContents: true
        outputEval: $(self[0].contents)

stdout: output.txt
baseCommand: echo
