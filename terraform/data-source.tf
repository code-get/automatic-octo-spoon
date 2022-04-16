
data "local_file" "key_pair_file" {
  filename = "../keys/${var.key_pair_filename}"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

