cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bash, -c]
arguments:
  - |
    mkdir -p foo
    touch baz.txt
    touch foo/bar.txt
inputs: []
outputs:
  stuff:
    type: Directory
    outputBinding:
      glob: $(runtime.outdir)
