stack "prod" {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/stacks/environment"
  path   = "prod"
}
