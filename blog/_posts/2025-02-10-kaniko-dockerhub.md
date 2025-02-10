---
layout: post
title: 'Quick Start, Minikube Jenkins' 
author: haeyeon.hwang
tags: [jenkins, github, pipeline, kaniko]
description: >
  Jenkins Kaniko 
image: /assets/img/blog/argocd.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

# Kaniko

kaniko.yaml 

~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: kaniko
spec:
  restartPolicy: Never
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    imagePullPolicy: Always
    args: [ "--dockerfile=./Dockerfile",
            "--context=git://github.com/pushdown99/jenkins-webhook.git",
            "--destination=pushdown99/kaniko-demo" ]
    volumeMounts: #  volumeMount or env 선택
    - name: kaniko-secret
      mountPath: /kaniko/.docker/
  restartPolicy: Never
  volumes: #  env 선택 시 불필요
  - name: kaniko-secret
    secret:
      secretName: regcred
      items:
        - key: .dockerconfigjson
          path: config.json
~~~

config.json

~~~console
AUTH=$(echo -n "${DOCKER_USERNAME}:${DOCKER_PASSWORD}" | base64)
cat << EOF > config.json
{
    "auths": {
        "https://index.docker.io/v1/": {
            "auth": "${AUTH}"
        }
    }
}
EOF
~~~

~~~json
{
    "auths": {
      "https://index.docker.io/v1/": {
        "auth": ""
      }
    }
}

k8s command 

~~~console
kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v1/ --docker-username= --docker-password= --docker-email=

kubectl create -f kaniko.yaml

kubectl get po

kubectl logs kaniko

~~~