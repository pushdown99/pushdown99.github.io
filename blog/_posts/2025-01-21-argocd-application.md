---
layout: post
title: 'Build ArgoCD Application' 
author: haeyeon.hwang
tags: [application, argocd]
description: >
  Build ArgoCD Application 
image: /assets/img/blog/argocd.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

## Build ArgoCD Application

#### ArgoCD Application

~~~yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: nginx
  namespace: argocd
  finalizers:
  - resources-finalizer.argocd.argoproj.io
spec:
  destination:
    namespace: nginx
    server: https://kubernetes.default.svc
  project: default
  source:
    helm:
      valueFiles:
      - ci/my-values.yaml
    path: nginx-webserver/nginx-15.1.0
    repoURL: https://github.com/junghoon2/k8s-class.git
    targetRevision: HEAD
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
    - CreateNamespace=true

~~~