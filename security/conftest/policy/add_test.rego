package main

test_add if {
    dockerfile := [{ "Cmd": "ADD", "Value": ["/apps/appdynamics/"] }]

    d := deny with input as dockerfile
    count(d) == 1
}

test_copy if {
    dockerfile := [{ "Cmd": "COPY", "Value": ["/apps/appdynamics/"] }]

    d := deny with input as dockerfile
    count(d) == 0
}
