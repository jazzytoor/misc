data "aws_caller_identity" "this" {}

data "http" "iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/refs/heads/main/docs/install/iam_policy.json"
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_name
}

data "aws_route53_zone" "this" {
  name = var.domain
}

data "aws_elb_hosted_zone_id" "current" {}

data "kubernetes_ingress_v1" "argocd" {
  metadata {
    name      = "argocd-server"
    namespace = "argocd"
  }

  depends_on = [
    helm_release.argocd
  ]
}
