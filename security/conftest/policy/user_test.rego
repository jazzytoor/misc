package main

test_no_user if {
    dockerfile := [
        { "Cmd": "run", "Value": ["echo 'no user'" ] }
    ]

    d := deny with input as dockerfile
    count(d) == 1
}

test_user_root if {
    dockerfile := [
        { "Cmd": "user", "Value": ["root"] }
    ]

    d := deny with input as dockerfile
    count(d) == 1
}

test_user_zero if {
    dockerfile := [
        { "Cmd": "user", "Value": ["0"] }
    ]

    d := deny with input as dockerfile
    count(d) == 1
}

test_user_non_root if {
    dockerfile := [
        { "Cmd": "user", "Value": ["appuser"] }
    ]

    d := deny with input as dockerfile
    count(d) == 0
}

test_user_root_then_non_root if {
    dockerfile := [
        { "Cmd": "user", "Value": ["root"] },
        { "Cmd": "user", "Value": ["appuser"] }
    ]

    d := deny with input as dockerfile
    count(d) == 0
}

test_user_non_root_then_root if {
    dockerfile := [
        { "Cmd": "user", "Value": ["appuser"] },
        { "Cmd": "user", "Value": ["root"] }
    ]

    d := deny with input as dockerfile
    count(d) == 1
}

test_user_uppercase_root if {
    dockerfile := [
        { "Cmd": "user", "Value": ["Root"] }
    ]

    d := deny with input as dockerfile
    count(d) == 1
}
