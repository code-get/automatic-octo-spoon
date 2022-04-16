
variable "instance_name" {
  description = "The AWS Lightsail Instance Name"
  type        = string
}

variable "availability_zone" {
  description = "The AWS Lightsail Availability Zone"
  type        = string
  default     = "ca-central-1a"
}

variable "blueprint_id" {
  description = "The AWS Lightsail Blueprint ID"
  type        = string
  default     = "ubuntu_20_04"  
}

variable "bundle_id" {    
  description = "The AWS Lightsail Bundle ID"
  type        = string
  default     = "nano_2_0"
}

variable "provisioner_script" {
  description = "The path to the provisioner script"
  type        = string
}

variable "private_key" {
  description = "The Private Key for the Provisioner script"
  type        = string
}

