

# microk8s - Bare Metal Quick Install
Build Process Cheat Sheet  

![download](https://user-images.githubusercontent.com/993459/111545821-ea5d5880-8733-11eb-9352-d22f812e9fb0.png)

## Base Install - Ubuntu 20.x
1. sudo snap install microk8s --classic
2. sudo microk8s status --wait-ready
3. sudo microk8s enable dashboard dns registry ingress
4. sudo snap alias microk8s.kubectl kubectl    //'create alias'

## Ingress Install - Ubuntu 20.x

1. sudo kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/baremetal/deploy.yaml

- [bare Metal](https://kubernetes.github.io/ingress-nginx/deploy/#bare-metal)

2. sudo kubectl get pods -n ingress-nginx   -l app.kubernetes.io/name=ingress-nginx --watch
3. sudo kubectl get svc --namespace=ingress-nginx
4. Set the Ingress loadbalancers External IP Address 
   - sudo kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{"spec": {"type": "LoadBalancer", "externalIPs":["3.15.237.254"]}}'

5. Service -  apple

   sudo kubectl apply -f service1.yaml  
   or  
   sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/service_apple.yaml  
   
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
   or  
   sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/service_banana.yaml  
   
   
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

sudo kubectl apply -f service_ingress.yaml 
   or  
   sudo kubectl apply -f https://raw.githubusercontent.com/mallond/microk8s/main/service_ingress.yaml

> Note: Ingress implecetly supports TLS and the below annotations will force a redirect out of http to https.  
>
<img src="https://user-images.githubusercontent.com/993459/111708157-940b1b00-8802-11eb-81b3-f48a3a7c25b0.png" width="200" height="100"/>

```
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
```

```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
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
# Ingress Basic Authentication
- htpasswd -c auth myfoo 
- sudo kubectl create secret generic basic-auth --from-file=auth
- sudo kubectl get secret basic-auth -o yaml

# Test Ingress Controller

- sudo kubectl get svc --namespace=ingress-nginx
```
~$ sudo kubectl get svc --namespace=ingress-nginx
NAME                                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
ingress-nginx-controller-admission   ClusterIP   10.152.183.29    <none>        443/TCP                      74s
ingress-nginx-controller             NodePort    10.152.183.142   <none>        80:30609/TCP,443:31953/TCP   73s
```
- curl 10.152.183.142/apple
- curl 10.152.183.142/banana

## Add External IP
sudo kubectl patch svc ingress-nginx-controller -n ingress-nginx -p '{"spec": {"type": "LoadBalancer", "externalIPs":["3.15.237.254"]}}'
- netstat -ntlu
- netstat -na | grep :80
- sudo ufw allow 80
- sudo ufw enable



#### Test TLS
- curl https://10.152.183.142/banana -k
- Note: -k allows unsecured connections

# Kubectl useful memory aid
- sudo kubectl apply -f your.yaml  
- kubectl get svc  
- kubectl get svc --namespace=ingress-nginx
- kubectl get namespace
- kubectl cluster-info
- kubectl -n kube-system edit service kubernetes-dashboar    "Real time editing"
- curl http://localhost:32000/v2/_catalog?n=1                "Microk8s local registry"
- kubectl get deployments --all-namespacessudo microk8s dashboard-proxy "Dashboard check and token"
- 

# Misc
ClusterIP: Exposes the service on a cluster-internal IP. Choosing this value makes the service only reachable from within the cluster. This is the default ServiceType

NodePort: Exposes the service on each Node’s IP at a static port (the NodePort). A ClusterIP service, to which the NodePort service will route, is automatically created. You’ll be able to contact the NodePort service, from outside the cluster, by requesting <NodeIP>:<NodePort>.

LoadBalancer: Exposes the service externally using a cloud provider’s load balancer. NodePort and ClusterIP services, to which the external load balancer will route, are automatically created.


