resource "aws_security_group" "icmp" {
  for_each = module.vpc

  name        = "${var.service}-${each.key}-icmp"
  description = "Allow ICMP from other VPC"
  vpc_id      = each.value.vpc_id

  ingress {
    protocol  = "icmp"
    from_port = -1
    to_port   = -1
    cidr_blocks = [
      local.vpcs[
        each.key == "app1" ? "app2" : "app1"
      ].cidr
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.default_tags
}

module "ec2" {
  for_each = module.vpc

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name = "${var.service}-${each.key}"

  instance_type = "t3.small"

  create_iam_instance_profile = true
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  subnet_id              = each.value.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.icmp[each.key].id]

  associate_public_ip_address = false

  tags = local.default_tags
}
