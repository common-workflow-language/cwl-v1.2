class: CommandLineTool
cwlVersion: v1.2
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: script.sh
        entry: |
          echo \
            "My country, 'tis of thee," \
            "Sweet land of $(inputs.liberty)"

baseCommand: ["bash", "script.sh"]

inputs:
  liberty:
    type: string?
    default: liberty

outputs:
  out: stdout

stdout: out.txt
