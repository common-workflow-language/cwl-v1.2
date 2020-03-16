class: CommandLineTool
cwlVersion: v1.2.0-dev2
requirements:
  DockerRequirement:
    dockerPull: python:3
  NetworkAccess:
    networkAccess: true
inputs: []
outputs: []
baseCommand: python
arguments:
  - "-c"
  - valueFrom: |
      import urllib.request
      assert(urllib.request.urlopen("http://commonwl.org").code == 200)