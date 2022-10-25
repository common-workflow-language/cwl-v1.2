class: CommandLineTool
cwlVersion: v1.2
doc: "Describes one of the inputs and the input itself is optional. However,
      if it is there then all parts of the input (all fields in the record) must be there"
baseCommand:
  - echo
inputs:
  one:
    type:
      - 'null'
      - type: record
        fields:
          - name: one
            type: string
            inputBinding:
              position: 1
          - name: two
            type: string
            inputBinding:
              position: 2
  two:
    type: string
outputs:
  output_one:
    type: stdout
stdout: output.txt