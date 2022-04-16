
terraform {
  required_version = ">= 1.1"
  backend "s3" {
    profile = "default"
    region  = "ca-central-1"
    key     = "hello-kubeworld/terraform.tfstate"
    bucket  = "code-get"
  }
}

