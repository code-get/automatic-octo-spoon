
data "local_file" "key_pair_file" {
  filename = "../keys/${var.key_pair_filename}"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_route53_zone" "zone" {
  name         = "${var.domain_name}."
  private_zone = false
}

