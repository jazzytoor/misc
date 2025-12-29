package main
import rego.v1

# Collect all USER instructions (normalized to lowercase)
get_all_users = all_users_array if {
  all_users_array = [ user |
    some i
    lower(input[i].Cmd) == "user"
    user := lower(input[i].Value[0])
  ]
}

# Index of the last USER instruction
last_user_index = i if {
  some i
  lower(input[i].Cmd) == "user"
  not exists_later_user(i)
}

exists_later_user(i) if {
  some j
  j > i
  lower(input[j].Cmd) == "user"
}

# Match root / root-equivalent users
user_match(user) if { user == "root" }
user_match(user) if { user == "0" }
user_match(user) if { startswith(user, "root:") }
user_match(user) if { startswith(user, "0:") }

# No USER instruction at all
deny contains msg if {
  users := get_all_users
  count(users) == 0

  msg := "You must specify an explicit non-root user, e.g. USER appuser."
}

# Last USER is root (or equivalent)
deny contains msg if {
  users := get_all_users
  count(users) > 0

  last := users[count(users) - 1]
  user_match(last)

  i := last_user_index

  msg := sprintf("Line %d: The last USER specified must be a non-root user, e.g. USER appuser", [i])
}
