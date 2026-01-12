module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 6.0"

  validation_method = "DNS"

  domain_name               = var.domain
  zone_id                   = data.aws_route53_zone.this.id
  subject_alternative_names = ["${local.subdomain}.${var.domain}"]

  tags = local.default_tags
}

module "records" {
  source  = "terraform-aws-modules/route53/aws"
  version = "~> 6.0"

  create_zone = false
  name        = var.domain

  records = {
    alb = {
      name = local.subdomain
      type = "A"
      alias = {
        name    = data.kubernetes_ingress_v1.argocd.status[0].load_balancer[0].ingress[0].hostname
        zone_id = data.aws_elb_hosted_zone_id.current.id
      }
    }
  }
}
