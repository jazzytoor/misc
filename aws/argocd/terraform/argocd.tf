resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "9.2.4"

  values = [
    templatefile("${path.module}/argocd.yaml", {
      host_name       = "${local.subdomain}.${var.domain}"
      certificate_arn = module.acm.acm_certificate_arn
      subnets         = join(",", module.vpc.public_subnets)
      sso_url         = var.sso["url"]
      certificate     = var.sso["certificate"]
      group_id        = var.sso["group_id"]
    })
  ]

  depends_on = [
    module.eks,
    helm_release.aws_lbc
  ]
}
