#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: CommandLineTool

inputs:
  a_string:
    type: string
    default: z
  a_string_array:
    type: string[]
    default: [a, b, c]
  a_true:
    type: boolean
    default: true
  an_array_of_trues:
    type: boolean[]
    default: [true, true, true]
  an_array_of_falses:
    type: boolean[]
    default: [false, false, false]
  an_array_of_mixed_booleans:
    type: boolean[]
    default: [false, true, false]
  an_int:
    type: int
    default: 42
  an_array_of_ints:
    type: int[]
    default: [42, 23]
  a_long:
    type: long
    default: 4147483647
  an_array_of_longs:
    type: long[]
    default: [4147483647, -4147483647]
  a_float:
    type: float
    default: 4.2
  an_array_of_floats:
    type: float[]
    default: [2.3, 4.2]
  a_double:
    type: double
    default: 1000000000000000000000000000000000000000000
  an_array_of_doubles:
    type: double[]
    default:
      - 1000000000000000000000000000000000000000000
      - -1000000000000000000000000000000000000000000
arguments:
 - '{"result":$(inputs)}'
outputs:
  result:
    type:
      type: record
      fields:
        a_string: string
        a_string_array: string[]
        a_true: boolean
        an_array_of_trues: boolean[]
        an_array_of_falses: boolean[]
        an_array_of_mixed_booleans: boolean[]
        an_int: int
        an_array_of_ints: int[]
        a_long: long
        an_array_of_longs: long[]
        a_float: float
        an_array_of_floats: float[]
        a_double: double
        an_array_of_doubles: double[]
baseCommand: echo
stdout: cwl.output.json
