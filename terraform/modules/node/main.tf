
resource "aws_lightsail_instance" "instance" {
  name              = var.instance_name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = "LightsailDefaultKeyPair"

  connection {
    type        = "ssh"
    user        = self.username
    host        = self.public_ip_address
    private_key = var.private_key
  }

  provisioner "file" {
    content = var.private_key
    destination = "/home/${self.username}/key.pem"
  }

  provisioner "file" {
    source      = var.provisioner_script
    destination = "/tmp/init.sh"
  }

  provisioner "remote-exec" {
	inline = [
      "chmod +x /tmp/init.sh",
      "/tmp/init.sh"
	]
  }
}

resource "aws_lightsail_static_ip_attachment" "static_ip_attachment" {
  static_ip_name = aws_lightsail_static_ip.static_ip.id
  instance_name  = aws_lightsail_instance.instance.id
}

resource "aws_lightsail_static_ip" "static_ip" {
  name = "${aws_lightsail_instance.instance.name}-ip"
}

