#!/bin/bash
sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/service_apple.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/service_banana.yaml
sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/service_ingress.yaml
