#!/bin/bash
echo 'Installing microk8s... make take a few minutes'
sudo snap install microk8s --classic
sudo microk8s status --wait-ready
sudo microk8s enable dashboard dns registry ingress
sudo snap alias microk8s.kubectl kubectl
