---
layout: post
title: 'k8s Quick-Start with Minikube' 
author: haeyeon.hwang
tags: [k8s, minikube]
description: >
  k8s Quick-Start with Minikube 
image: /assets/img/blog/argocd.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

## minikube

#### Installation / Dashboard

~~~console
minikube start
minikube dashboard
~~~

---

## ArgoCD

#### Installation / Dashboard

~~~console
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
minikube tunnel
minikube service argocd-server -n argocd
~~~

#### Get password (User: `admin`)

~~~console
argocd admin initial-password -n argocd
~~~

----

## Harbor

#### add repo

~~~console
helm repo add harbor https://helm.goharbor.io
helm repo list
~~~

#### fetch & unzip chart

~~~console
helm fetch harbor/harbor
tar zxvf harbor-x.x.x.tgz
~~~

Download: [`values.yaml`](/assets/doc/values.yaml) 

expose type to `loadBalancer` and tls `disable`

~~~yaml
expose:
  type: loadBalancer
  ports:
    httpPort: 80
  tls:
    enabled: false # true
~~~

#### Installation

~~~console
kubectl create ns hb
helm install harbor -f values.yaml . -n hb
minikube tunnel
~~~

browse to `http://localhost`
id: `admin`, password: `Harbor12345`

--- 

## MinIO deploying with ArgoCD

#### `git` repositories

~~~console
https://github.com/pushdown99/argo-minio.git
~~~

app/[`k8s-deployment.yaml`](/assets/doc/k8s-deployment.yaml.yaml)

~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minio
spec:
  replicas: 1
  selector:
    matchLabels:
      app: minio
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: minio
    spec:
      volumes:
      - name: storage
        hostPath:
          path: /data/minio
      containers:
      - name: minio
        image: minio/minio:latest
        args:
        - server
        - --console-address
        - ":9001"
        - "/storage"
        env:
        - name: MINIO_ROOT_USER
          value: "minio"
        - name: MINIO_ROOT_PASSWORD
          value: "minio123"
        - name: TZ
          value: Asia/Seoul
        - name: LANG
          value: ko_KR.utf8
        ports:
        - containerPort: 9000
          hostPort: 9000
        - containerPort: 9001
          hostPort: 9001
        volumeMounts:
        - name: storage
          mountPath: "/storage"
---
apiVersion: v1
kind: Service
metadata:
  name: minio
  labels:
    run: minio
spec:
  type: NodePort
  ports:
  - port: 9000
    targetPort: 9000
    nodePort: 30333
    name: api
  - port: 9001
    targetPort: 9001
    nodePort: 30334
    name: ui
  selector:
    app: minio
~~~

#### MinIO Application creation with ArgoCD

#### `git` repositories

~~~console
https://github.com/pushdown99/argo-minio.git
~~~

app/k8s-deployment.yaml

~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myweb
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myweb
  template:
    metadata:
      labels:
        app: myweb
    spec:
      containers:
      - name: myweb
        image: pushdown99/myweb:latest
        ports:
        - containerPort: 3000
---
apiVersion: v1
kind: Service
metadata:
  name: myweb-service
spec:
  type: NodePort
  selector:
    app: myweb
  ports:
  - protocol: TCP
    port: 3000
    targetPort: 3000
    nodePort: 30000
~~~

#### HOW-TO

1. Login to ArgoCD
2. Applications > `+ New APP`
3. Fill-in

    - (GENERAL) Application Name: `minio`
    - (GENERAL) Project Name: `default`
    - (SOURCE) Repository URL: [`https://github.com/pushdown99/argo-minio.git`](https://github.com/pushdown99/argo-minio.git)
    - (SOURCE) Path: `app`
    - (DESTINATION) Cluster URL: `https://kubernetes.default.svc`
    - (DESTINATION) Namespace: `default`

4. `Create`
5. `SYNC`
6. `kubectl` commands

~~~console
kubectl get svc

NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP                         35m
minio        NodePort    10.98.171.143   <none>        9000:30333/TCP,9001:30334/TCP   64s

kubectl port-forward svc/minio 9000:9000 9001:9001
~~~

7. browse to [`http://127.0.0.1:9000`](http://127.0.0.1:9000)

    id: `minio`, password: `minio123`

## CI/CD with ArgoCD

#### Sample Application with ArgoCD

~~~console
https://github.com/pushdown99/cicd-node.git
~~~

app/`k8s-deployment.yaml`

~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myweb
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myweb
  template:
    metadata:
      labels:
        app: myweb
    spec:
      containers:
      - name: myweb
        image: pushdown99/myweb:latest
        ports:
        - containerPort: 3000
---
apiVersion: v1
kind: Service
metadata:
  name: myweb-service
spec:
  type: NodePort
  selector:
    app: myweb
  ports:
  - protocol: TCP
    port: 3000
    targetPort: 3000
    nodePort: 30000
~~~

HOW-TO

1. Login to ArgoCD
2. Applications > `+ New APP`
3. Fill-in

    - (GENERAL) Application Name: `myweb`
    - (GENERAL) Project Name: `default`
    - (SOURCE) Repository URL: [`https://github.com/pushdown99/cicd-node.git`](https://github.com/pushdown99/cicd-node.git)
    - (SOURCE) Path: `app`
    - (DESTINATION) Cluster URL: `https://kubernetes.default.svc`
    - (DESTINATION) Namespace: `default`

4. `Create`
5. `SYNC`
6. `kubectl` commands

~~~console
kubectl get svc

NAME            TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
kubernetes      ClusterIP   10.96.0.1        <none>        443/TCP                         54m
minio           NodePort    10.98.171.143    <none>        9000:30333/TCP,9001:30334/TCP   20m
myweb-service   NodePort    10.104.220.233   <none>        3000:30000/TCP                  14m

kubectl port-forward svc/myweb-service 3000:3000
~~~

7. browse to [`http://127.0.0.1:3000`](http://127.0.0.1:3000)
