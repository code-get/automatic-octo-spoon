
module "kube-controller" {
  source = "./modules/node"

  instance_name = "kube-k3s-controller"
  bundle_id     = "micro_2_0"
 
  provisioner_script = "./scripts/init.sh"
  private_key        = data.local_file.key_pair_file.content
}

resource "aws_route53_record" "kube-controller" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "kubectl.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [module.kube-controller.public_ip_address]
}

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

resource "aws_lightsail_instance_public_ports" "connect-worker" {
  instance_name = module.kube-controller.instance_name

  port_info {
    protocol  = "tcp"
    from_port = 6443
    to_port   = 6443
    cidrs = [
      "${module.kube-worker[0].public_ip_address}/32",
      "${module.kube-worker[1].public_ip_address}/32",
      "${module.kube-worker[2].public_ip_address}/32",
      "${chomp(data.http.myip.body)}/32"
    ]
  }
  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidrs = [
      "${module.kube-worker[0].public_ip_address}/32",
      "${module.kube-worker[1].public_ip_address}/32",
      "${module.kube-worker[2].public_ip_address}/32",
      "${chomp(data.http.myip.body)}/32"
    ]
  }
}

