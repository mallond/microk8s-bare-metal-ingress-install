#!/bin/bash
sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/baremetal/deploy.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/service_apple.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/service_banana.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/influxdb.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/service_ingress.yaml
