locals {
  vpcs = {
    app1 = {
      cidr = "10.0.0.0/16"
    }
    app2 = {
      cidr = "10.1.0.0/16"
    }
  }

  rt_to_vpc = flatten([
    for vpc_key, vpc in module.vpc : [
      for rt_id in vpc.private_route_table_ids : {
        rt_id   = rt_id
        vpc_key = vpc_key
      }
    ]
  ])

  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  default_tags = {
    Name = var.service
  }
}
