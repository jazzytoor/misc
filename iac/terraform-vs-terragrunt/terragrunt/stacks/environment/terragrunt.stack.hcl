unit "vpc" {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/units/vpc"
  path   = "vpc"
}