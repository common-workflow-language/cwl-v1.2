#
# This is a variant of revsort.cwl where the "sorted"
# step has not yet been implemented, but has a placeholder
# Operation.
#
class: Workflow
doc: "Reverse the lines in a document, then sort those lines."
cwlVersion: v1.2

inputs:
  input:
    type: File
    doc: "The input file to be processed."
  reverse_sort:
    type: boolean
    default: true
    doc: "If true, reverse (decending) sort"

outputs:
  output:
    type: File
    outputSource: sort/sorted
    doc: "The output with the lines reversed and sorted."

steps:
  rev:
    in:
      input: input
    out: [output]
    run: revtool.cwl

  sort:
    in:
      input: rev/output
      reverse: reverse_sort
    out: [sorted]
    run:
      class: Operation
      id: "sort"
      doc: "Sort the lines of the file"
      inputs:
        input:
          type: File
          doc: "The input file to be sorted."
        reverse:
          type: boolean
          default: true
          doc: "If true, reverse (decending) sort"
      outputs:
        sorted:
          type: File
          doc: "The sorted file"
