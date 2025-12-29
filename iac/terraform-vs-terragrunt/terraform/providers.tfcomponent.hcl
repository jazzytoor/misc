required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 6.14.1"
  }
}

provider "aws" "this" {
  config {
    region = var.region
  }
}
