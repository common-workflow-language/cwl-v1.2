#!/usr/bin/env cwl-runner
$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/
$schemas:
  - foaf.rdf
  - dcterms.rdf

cwlVersion: v1.2
class: CommandLineTool
doc: "Test that a command line document with metadata is executed successfully."

dct:creator:
  id: "http://orcid.org/0000-0003-3566-7705"
  class: foaf:Person
  foaf:name: Peter Amstutz
  foaf:mbox: "mailto:peter.amstutz@curoverse.com"

hints:
  DockerRequirement:
    dockerPull: docker.io/debian:stable-slim
inputs: []
outputs: []
baseCommand: "true"
