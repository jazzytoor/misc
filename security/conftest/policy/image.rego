package main
import rego.v1

disallowed_tags := {"latest"}
disallowed_images := {"adoptopenjdk/openjdk11"}

deny contains msg if {
  input[i].Cmd == "from"
  image_ref := input[i].Value[0]

  parts := split(image_ref, ":")
  count(parts) > 1

  tag := lower(parts[count(parts) - 1])
  tag in disallowed_tags

  msg := sprintf("Line %d: Image tag '%s' is not allowed.", [i, tag])
}

deny contains msg if {
  input[i].Cmd == "from"
  image_ref := input[i].Value[0]

  image := lower(split(image_ref, ":")[0])
  image in disallowed_images

  msg := sprintf("Line %d: Image '%s' is not allowed.", [i, image])
}

deny contains msg if {
  input[i].Cmd == "from"
  image_ref := input[i].Value[0]

  not contains(image_ref, ":")

  msg := sprintf(
    "Line %d: Image tag must be explicitly specified.",
    [i]
  )
}
