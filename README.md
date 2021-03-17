# microk8s
Build Process Cheat Sheet  

![download](https://user-images.githubusercontent.com/993459/111545821-ea5d5880-8733-11eb-9352-d22f812e9fb0.png)

## Base Install - Ubuntu 20.x
1. sudo snap install microk8s --classic
2. sudo microk8s status --wait-ready
3. sudo microk8s enable dashboard dns registry istio ingress
4. sudo snap alias microk8s.kubectl kubectl    'create alias

## Ingress Install - Ubuntu 20.x
1. sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/do/deploy.yaml
2. sudo kubectl get pods -n ingress-nginx   -l app.kubernetes.io/name=ingress-nginx --watch
3. sudo kubectl get svc --namespace=ingress-nginx
4. Set the Ingress loadbalancers External IP Address 
   - sudo kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{"spec": {"type": "LoadBalancer", "externalIPs":["172.31.23.252"]}}'

## Test Artifacts to be used with Ingress
```{r klippy, echo=FALSE, include=TRUE}
klippy::klippy()
apiVersion: v1
kind: Service
metadata:
  name: echo1
spec:
  ports:
  - port: 80
    targetPort: 5678
  selector:
    app: echo1
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: echo1
spec:
  selector:
    matchLabels:
      app: echo1
  replicas: 2
  template:
    metadata:
      labels:
        app: echo1
    spec:
      containers:
      - name: echo1
        image: hashicorp/http-echo
        args:
        - "-text=echo1"
        ports:
        - containerPort: 5678
```
# Kubectl
- sudo kubectl apply -f your.yaml



