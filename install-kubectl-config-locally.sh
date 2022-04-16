#!/usr/bin/env bash

scp -i keys/LightsailDefaultKey-ca-central-1.pem ubuntu@kubectl.code-get.com:/etc/rancher/k3s/k3s.yaml .
sed -i -e "s/127.0.0.1/kubectl.code-get.com/g" k3s.yaml
mkdir ~/.kube
mv k3s.yaml ~/.kube/config

