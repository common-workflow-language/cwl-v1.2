class: CommandLineTool
cwlVersion: v1.2
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: script.sh
        entry: |
          echo \
            "My country, 'tis of thee," \
            "Sweet land of liberty"

baseCommand: ["bash", "script.sh"]

inputs: []

outputs:
  out: stdout

stdout: out.txt
