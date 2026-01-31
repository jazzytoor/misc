module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 3.0"

  name = var.service

  enable_auto_accept_shared_attachments = true

  vpc_attachments = {
    app1 = {
      vpc_id     = module.vpc["app1"].vpc_id
      subnet_ids = module.vpc["app1"].private_subnets

      dns_support  = true
      ipv6_support = false
    }

    app2 = {
      vpc_id     = module.vpc["app2"].vpc_id
      subnet_ids = module.vpc["app2"].private_subnets

      dns_support  = true
      ipv6_support = false
    }
  }

  tags = local.default_tags
}
