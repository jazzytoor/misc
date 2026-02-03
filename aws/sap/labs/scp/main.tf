resource "aws_organizations_policy" "scps" {
  for_each = local.scps

  name        = each.value.name
  description = each.value.description
  type        = "SERVICE_CONTROL_POLICY"

  content = data.aws_iam_policy_document.scps[each.key].json

  tags = local.default_tags
}

resource "aws_organizations_policy_attachment" "scps" {
  for_each = local.scps

  policy_id = aws_organizations_policy.scps[each.key].id
  target_id = data.aws_organizations_organization.org.roots[0].id
}
