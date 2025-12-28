identity_token "aws" {
  audience = ["aws.workload.identity"]
}

# deployment "development" {
#   inputs = {
#     regions        = "eu-west-2"
#     identity_token = identity_token.aws.jwt
#   }
# }

deployment "production" {
  inputs = {
    regions        = "eu-west-2"
    identity_token = identity_token.aws.jwt
    environment    = "prod"
  }
}