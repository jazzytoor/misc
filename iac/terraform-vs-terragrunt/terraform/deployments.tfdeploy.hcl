identity_token "aws" {
  audience = ["aws.workload.identity"]
}

deployment "development" {
  inputs = {
    regions        = var.region
    identity_token = identity_token.aws.jwt
    environment    = "dev"
  }
}

deployment "production" {
  inputs = {
    regions        = var.region
    identity_token = identity_token.aws.jwt
    environment    = "prod"
  }
}
