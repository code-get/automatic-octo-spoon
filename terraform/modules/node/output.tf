
output "instance_id" {
  value = aws_lightsail_instance.instance.id
}

output "instance_name" {
  value = var.instance_name
}

output "username" {
  value = aws_lightsail_instance.instance.username
}

output "public_ip_address" {
  value = aws_lightsail_instance.instance.public_ip_address
}

