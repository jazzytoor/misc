package main
import rego.v1

deny contains msg if {
  some i
  lower(input[i].Cmd) == "add"
  msg := sprintf("Line %d: Use COPY instead of ADD", [i])
}
