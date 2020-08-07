#
# Example of an operation that has not yet been implemented
#
class: Operation
cwlVersion: v1.2

# an Operation is a placeholder for a CommandLineTool or
# Workflow to be added later, therefore its documentation
# are very important.
id: reverse
doc: "Reverse each line"

# The "inputs" array work the same as in CommandLineTool, but do
# not have any inputBinding
inputs:
  input:
    type: File

# The "outputs" array defines the structure of the output object, just like
# in CommandLineTool, but without outputBinding
outputs:
  output:
    type: File

# There are no "run" or "steps" command (FIXME: Should they be allowed?)
