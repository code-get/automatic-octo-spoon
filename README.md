# hello-kubeworld
A Demo of a Kubernetes Cluster Running on AWS Lightsail

## Prerequisites

terraform 1.1.x
awscli 2.5.x

## AWS Lightsail Key Pair

Copy your AWS Lightsail Key Pair pem file under the **keys** directory then update the variable **key_pair_filename** in the terraform.tfvars file

## Provision

To provision the K3s Cluster Nodes run the following Terraform configuration

``` bash
cd terraform
terraform init
terraform plan -out=terraform-plan
terraform apply terraform-plan
```

## Configure

To configure the K3s Cluster Nodes run the following Ansible Playbooks

``` bash
cd playbooks
ansible-playbook -i hosts healthcheck.yml
ansible-playbook -i hosts sethostnames.yml
ansible-playbook -i hosts controller.yml
ansible-playbook -i hosts workers.yml
```

## Download the ~/.kube/config

On Rancher this file is located at **/etc/rancher/k3s/k3s.yaml** and replace "localhost" with your hostname

``` bash
./install-kubectl-config-locally.yml
```

