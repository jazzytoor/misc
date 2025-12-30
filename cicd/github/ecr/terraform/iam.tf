module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "ecr"

  create_login_profile = false
  create_access_key    = true

  create_inline_policy = true
  inline_policy_permissions = {
    EcrPush = {
      effect = "Allow"
      actions = [
        "ecr:CompleteLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:InitiateLayerUpload",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:BatchGetImage"
      ]
      resources = [
        "arn:aws:ecr:${var.region}:${data.aws_caller_identity.this.account_id}:repository/misc"
      ]
    }
    EcrToken = {
      effect = "Allow"
      actions = [
        "ecr:GetAuthorizationToken"
      ]
      resources = ["*"]
    }
  }
}
