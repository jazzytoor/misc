module "iam_oidc_provider" {
  source = "terraform-aws-modules/iam/aws//modules/iam-oidc-provider"

  url            = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
}

module "s3_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "6.2.1"

  name = "github-actions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBuckets"]
        Resource = ["*"]
      }
    ]
  })
}

module "iam_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role"

  name = "github-actions"

  use_name_prefix = false

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = ["sts:AssumeRoleWithWebIdentity"]
      principals = [{
        type        = "Federated"
        identifiers = [module.iam_oidc_provider.arn]
      }]
      condition = [{
        test     = "StringEquals"
        variable = "token.actions.githubusercontent.com:aud"
        values   = ["sts.amazonaws.com"]
        },
        {
          test     = "StringLike"
          variable = "token.actions.githubusercontent.com:sub"
          values   = ["repo:jazzytoor/misc:ref:refs/heads/*"]
        }
      ]
    }
  }

  policies = {
    S3 = module.s3_policy.arn
  }
}
