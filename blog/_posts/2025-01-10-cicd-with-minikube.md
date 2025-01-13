---
layout: post
title: 'CI/CD with Minikube' 
author: haeyeon.hwang
tags: [cicd, k8s, minikube]
description: >
  CI/CD with Minikube 
image: /assets/img/blog/argocd.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

## CI/CD with Minikube

---

### ArgoCD Installation

~~~console
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl get svc -n argocd
kubectl port-forward svc/argocd-server -n argocd 8080:443
~~~

---

Login

User: admin
Password: 

~~~console
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

PWzPW5Oa8me81UBr
~~~

~~~console
> netstat -ano | findstr 8080

  TCP    0.0.0.0:8080           0.0.0.0:0              LISTENING       7588
  TCP    [::]:8080              [::]:0                 LISTENING       7588
  TCP    [::1]:8080             [::1]:64187            ESTABLISHED     7588
  TCP    [::1]:8080             [::1]:64188            ESTABLISHED     7588
  TCP    [::1]:64187            [::1]:8080             ESTABLISHED     15888
  TCP    [::1]:64188            [::1]:8080             ESTABLISHED     15888

> tasklist /FI "PID eq 7588"

이미지 이름                    PID 세션 이름              세션#  메모리 사용
========================= ======== ================ =========== ============
java.exe                      7588 Services                   0    385,468 K
~~~