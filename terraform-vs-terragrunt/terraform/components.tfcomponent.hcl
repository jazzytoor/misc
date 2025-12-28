component "vpc" {
  source   = "./../modules/vpc"
  inputs = {
    service = var.service
    environment = var.environment
  }
}