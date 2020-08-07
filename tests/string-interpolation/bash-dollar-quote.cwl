class: CommandLineTool
cwlVersion: v1.2
requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: script.sh
        entry: |
          echo \$(echo \
            "My country, 'tis of thee," \
            "Sweet land of liberty" | rev)
          echo '$(inputs.val)'     # produce val
          echo '\$(inputs.val)'    # produce $(inputs.val)
          echo
          echo '\\$(inputs.val)'   # produce \val
          echo '\\\$(inputs.val)'  # produce \$(inputs.val)
          echo
          echo '\\\\$(inputs.val)'  # produce \\val
          echo '\\\\\$(inputs.val)'  # produce \\$(inputs.val)
          echo
          echo '\\\\\\$(inputs.val)'  # produce \\\val
          echo '\\\\\\\$(inputs.val)'  # produce \\\$(inputs.val)
          echo
          echo '\\\\\\\\$(inputs.val)'  # produce \\\\val
          echo '\\\\\\\\\$(inputs.val)'  # produce \\\\$(inputs.val)
          echo
          echo '\\\\\\\\\\$(inputs.val)'  # produce \\\\\val
          echo '\\\\\\\\\\\$(inputs.val)'  # produce \\\\\$(inputs.val)
          echo '\'          # produce \
          echo '\\'         # produce \
          echo '\\\'        # produce \\
          echo '\\\\'       # produce \\
          echo '\\\\\'      # produce \\\
          echo '\\\\\\'     # produce \\\
          echo '\\\\\\\'    # produce \\\\
          echo '\\\\\\\\'   # produce \\\\
          echo '\\\\\\\\\'  # produce \\\\\
          echo '\\\\\\\\\\' # produce \\\\\
          echo '$'          # produce $
          echo '\$'         # produce \$
          echo '\\$'        # produce \$
          echo '$$'         # produce $$
          echo '$$$'        # produce $$$

baseCommand: ["bash", "script.sh"]

inputs:
  val:
    type: string
    default: "val"

outputs:
  out: stdout

stdout: out.txt
