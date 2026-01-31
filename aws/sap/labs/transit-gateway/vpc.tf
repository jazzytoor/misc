data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "vpc" {
  for_each = local.vpcs
  version  = "~> 6.0"

  source = "terraform-aws-modules/vpc/aws"

  name = "${var.service}-${each.key}"
  cidr = each.value.cidr

  azs             = local.azs
  private_subnets = [for k, _ in local.azs : cidrsubnet(each.value.cidr, 4, k)]
  public_subnets  = [for k, _ in local.azs : cidrsubnet(each.value.cidr, 8, k + 48)]

  enable_nat_gateway = true
  single_nat_gateway = true
}

resource "aws_route" "tgw" {
  count = length(local.rt_to_vpc)

  route_table_id = local.rt_to_vpc[count.index].rt_id

  destination_cidr_block = local.vpcs[
    local.rt_to_vpc[count.index].vpc_key == "app1" ? "app2" : "app1"
  ].cidr

  transit_gateway_id = module.tgw.ec2_transit_gateway_id
}
