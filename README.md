# microk8s
Build Process Cheat Sheet  

![download](https://user-images.githubusercontent.com/993459/111545821-ea5d5880-8733-11eb-9352-d22f812e9fb0.png)

## Base Install - Ubuntu 20.x
1. sudo snap install microk8s --classic
2. sudo microk8s status --wait-ready
3. sudo microk8s enable dashboard dns registry istio ingress
4. sudo snap alias microk8s.kubectl kubectl    //'create alias'

## Ingress Install - Ubuntu 20.x

1. sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/baremetal/deploy.yaml
2. sudo kubectl get pods -n ingress-nginx   -l app.kubernetes.io/name=ingress-nginx --watch
3. sudo kubectl get svc --namespace=ingress-nginx
4. Set the Ingress loadbalancers External IP Address 
   - sudo kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{"spec": {"type": "LoadBalancer", "externalIPs":["172.31.23.252"]}}'

5. Service -  apple

   sudo kubectl apply -f service1.yaml
   
```
kind: Pod
apiVersion: v1
metadata:
  name: apple-app
  labels:
    app: apple
spec:
  containers:
    - name: apple-app
      image: hashicorp/http-echo
      args:
        - "-text=apple"

---

kind: Service
apiVersion: v1
metadata:
  name: apple-service
spec:
  selector:
    app: apple
  ports:
    - port: 5678 # Default port for image
```

6. Service - banana

   sudo kubectl apply -f service2.yaml 
   
   
```
kind: Pod
apiVersion: v1
metadata:
  name: banana-app
  labels:
    app: banana
spec:
  containers:
    - name: banana-app
      image: hashicorp/http-echo
      args:
        - "-text=banana"

---

kind: Service
apiVersion: v1
metadata:
  name: banana-service
spec:
  selector:
    app: banana
  ports:
    - port: 5678 # Default port for image
```

7. Ingress 

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
        - path: /apple
          backend:
            serviceName: apple-service
            servicePort: 5678
        - path: /banana
          backend:
            serviceName: banana-service
            servicePort: 5678

```

# Kubectl
- sudo kubectl apply -f your.yaml  
- kubectl get svc  
- kubectl get svc --namespace=ingress-nginx




