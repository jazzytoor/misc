locals {
  variables = jsondecode(read_tfvars_file("${get_parent_terragrunt_dir()}/variables.auto.tfvars"))
  env_input = jsondecode(file("./${local.variables.environment}.json"))
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "eu-west-2"
}
EOF
}

inputs = merge(
  local.env_input,
  local.variables
)
