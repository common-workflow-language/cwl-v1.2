#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  letters: string[]
  letters2: string[]
  numbers: int[]
  numbers2: int[]
  start_line: string
  end_line: string

outputs:
  result:
    type:
      type: array
      items:
        type: array
        items:
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
        letter2: string
        numbers: int[]
        numbers2: int[]
        start_line: string
        end_line: string
      outputs:
        alphanum:
          type:
            type: array
            items:
              type: array
              items: string
          outputSource: scatternumbers/alphanum
      steps:
        scatternumbers:
          run:
            class: ExpressionTool
            inputs:
              letter: string
              letter2: string
              number: int
              number2: int
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
                               inputs.number2 +
                               inputs.letter +
                               inputs.letter2 +
                               inputs.end_line)
                };
              }
          in:
            letter: letter
            letter2: letter2
            number: numbers
            number2: numbers2
            start_line: start_line
            end_line: end_line
          scatter: [number, number2]
          scatterMethod: nested_crossproduct
          out: [alphanum]
    in:
      letter: letters
      letter2: letters2
      numbers: numbers
      numbers2: numbers2
      start_line: start_line
      end_line: end_line
    scatter: [letter, letter2]
    scatterMethod: nested_crossproduct
    out: [alphanum]
