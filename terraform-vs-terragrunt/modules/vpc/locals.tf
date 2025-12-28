locals {
  default_tags = {
    Name        = var.service
    Environment = var.environment
  }
}
