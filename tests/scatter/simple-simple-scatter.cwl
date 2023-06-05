#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  letters: string[]
  numbers: int[]
  start_line: string
  end_line: string

outputs:
  result:
    type:
      type: array
      items:
        type: array
        items: string
    outputSource: scatterletters/alphanum

steps:
  scatterletters:
    run:
      class: Workflow
      inputs:
        letter: string
        numbers: int[]
        start_line: string
        end_line: string
      outputs:
        alphanum:
          type: string[]
          outputSource: scatternumbers/alphanum
      steps:
        scatternumbers:
          run:
            class: ExpressionTool
            inputs:
              letter: string
              number: int
              start_line: string
              end_line: string
            outputs:
              alphanum:
                type: string
            expression: >
              ${
                return {
                  'alphanum': (inputs.start_line +
                               inputs.number +
                               inputs.letter +
                               inputs.end_line)
                };
              }
          in:
            letter: letter
            number: numbers
            start_line: start_line
            end_line: end_line
          scatter: number
          out: [alphanum]
    in:
      letter: letters
      numbers: numbers
      start_line: start_line
      end_line: end_line
    scatter: letter
    out: [alphanum]
