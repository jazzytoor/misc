data "aws_organizations_organization" "org" {}

data "aws_iam_policy_document" "scps" {
  for_each = local.scps

  version = "2012-10-17"

  dynamic "statement" {
    for_each = each.value.statements

    content {
      sid    = statement.value.sid
      effect = statement.value.effect

      actions     = try(statement.value.actions, null)
      not_actions = try(statement.value.not_actions, null)
      resources   = statement.value.resources

      dynamic "condition" {
        for_each = lookup(statement.value, "conditions", {})

        content {
          test     = condition.key
          variable = keys(condition.value)[0]
          values   = values(condition.value)[0]
        }
      }
    }
  }
}
