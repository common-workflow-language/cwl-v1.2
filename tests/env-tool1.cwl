class: CommandLineTool
cwlVersion: v1.2.0-dev4
inputs:
  in: string
outputs:
  out:
    type: File
    outputBinding:
      glob: out

requirements:
  EnvVarRequirement:
    envDef:
      TEST_ENV: $(inputs.in)

baseCommand: ["/bin/sh", "-c", "echo $TEST_ENV"]

stdout: out
