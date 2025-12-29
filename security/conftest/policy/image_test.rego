package main

test_deny_latest_tag if {
  dockerfile := [
    {
      "Cmd": "FROM",
      "Value": ["alpine:latest"]
    }
  ]

  d := deny with input as dockerfile
  count(d) == 1
}

test_deny_disallowed_image if {
  dockerfile := [
    {
      "Cmd": "FROM",
      "Value": ["adoptopenjdk/openjdk11:11-jre"]
    }
  ]

  d := deny with input as dockerfile
  count(d) == 1
}

test_allow_valid_image if {
  dockerfile := [
    {
      "Cmd": "FROM",
      "Value": ["alpine:3.19"]
    }
  ]

  d := deny with input as dockerfile
  count(d) == 0
}

test_deny_missing_tag if {
  dockerfile := [
    {
      "Cmd": "FROM",
      "Value": ["ubuntu"]
    }
  ]

  d := deny with input as dockerfile
  count(d) == 1
}
