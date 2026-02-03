data "aws_organizations_organization" "org" {}

data "aws_iam_policy_document" "deny_regions" {
  statement {
    sid    = "DenyAllOutsideRequestedRegions"
    effect = "Deny"

    not_actions = [
      "cloudfront:*",
      "iam:*",
      "organizations:*",
      "route53:*",
      "support:*"
    ]

    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"
      values   = [var.region]
    }
  }
}

resource "aws_organizations_policy" "deny_regions" {
  name    = "deny-all-outside-requested-regions"
  content = data.aws_iam_policy_document.deny_regions.json

  tags = local.default_tags
}

resource "aws_organizations_policy_attachment" "deny_regions" {
  policy_id = aws_organizations_policy.deny_regions.id
  target_id = data.aws_organizations_organization.org.roots[0].id
}
