---
layout: post
title: 'minikube-calico' 
author: haeyeon.hwang
tags: [minikube, calico, github]
description: >
  minikube-calico 
image: /assets/img/blog/argocd.png
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

## calico

~~~console
minikube start --cpus=4 --memory='7800mb'  --cni calico --insecure-registry '127.0.0.1:5000'
~~~