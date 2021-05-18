#!/usr/bin/env bash
echo 'installing microk8s'
sudo snap install microk8s --classic
sudo microk8s status --wait-ready
sudo microk8s enable dashboard dns registry ingress
sudo snap alias microk8s.kubectl kubectl    



