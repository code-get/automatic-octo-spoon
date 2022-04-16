
module "nfs-server" {
  count = 1
  source = "./modules/node"

  instance_name = "nfs-server${count.index}"
  bundle_id     = "micro_2_0"
 
  provisioner_script = "./scripts/init.sh"
  private_key        = data.local_file.key_pair_file.content
}

resource "aws_route53_record" "nfs-server" {
  count   = 1
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "nfs${count.index}.${var.domain_name}"
  type    = "A"
  ttl     = "300"
  records = [module.nfs-server[count.index].public_ip_address]
}

resource "aws_lightsail_instance_public_ports" "connect-nfs0" {
  instance_name = module.nfs-server[0].instance_name

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

  port_info {
    protocol  = "tcp"
    from_port = 2049
    to_port   = 2049
    cidrs = [
      "${module.kube-worker[0].public_ip_address}/32",
      "${module.kube-worker[1].public_ip_address}/32",
      "${module.kube-worker[2].public_ip_address}/32",
      "${chomp(data.http.myip.body)}/32"
    ]
  }

  port_info {
    protocol  = "udp"
    from_port = 2049
    to_port   = 2049
    cidrs = [
      "${module.kube-worker[0].public_ip_address}/32",
      "${module.kube-worker[1].public_ip_address}/32",
      "${module.kube-worker[2].public_ip_address}/32",
      "${chomp(data.http.myip.body)}/32"
    ]
  }
}

