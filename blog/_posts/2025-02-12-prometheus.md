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

## Prometheus

~~~console
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
#helm pull prometheus-community/kube-prometheus-stack
#tar zxfv kube-prometheus-stack-69.2.3.tgz
#cd kube-prometheus-stack/
helm show values prometheus-community/kube-prometheus-stack > values.yaml
code values.yaml
~~~

~~~yaml
adminPassword:
~~~

~~~console
helm install prometheus . -n monitoring -f values.yaml
minikube service  prometheus-grafana -n monitoring
~~~