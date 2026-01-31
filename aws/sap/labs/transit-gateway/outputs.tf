output "ec2_private_ips" {
  value = {
    for k, inst in module.ec2 :
    k => inst.private_ip
  }
}
