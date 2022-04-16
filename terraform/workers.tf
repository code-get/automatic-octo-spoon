
module "kube-worker" {
  count = 3 # three nodes
  source = "./modules/node"

  instance_name = "kube-k3s-worker${count.index}"
  bundle_id     = "micro_2_0"
 
  provisioner_script = "./scripts/init.sh"
  private_key        = data.local_file.key_pair_file.content
}

resource "aws_route53_record" "kube-worker" {
  count   = 3 
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "worker${count.index}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [module.kube-worker[count.index].public_ip_address]
}


