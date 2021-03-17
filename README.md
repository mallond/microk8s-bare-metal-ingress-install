# microk8s
Build Process Cheat Sheet  

![download](https://user-images.githubusercontent.com/993459/111545821-ea5d5880-8733-11eb-9352-d22f812e9fb0.png)

## Base Install - Ubuntu 20.x
1. sudo snap install microk8s --classic
2. sudo microk8s status --wait-ready
3. sudo microk8s enable dashboard dns registry istio ingress
4. sudo snap alias microk8s.kubectl kubectl    'create alias


