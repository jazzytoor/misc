output "iam_user_access_key_id" {
  description = "The access key ID"
  value       = module.iam_user.access_key_id
}

output "iam_user_access_key_secret" {
  description = "The access key secret"
  value       = module.iam_user.access_key_secret
  sensitive   = true
}
