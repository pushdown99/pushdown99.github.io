---
layout: post
title: 'Kiali Install' 
author: haeyeon.hwang
tags: [jenkins, github, pipeline, kaniko]
description: >
  Kiali Install 
image: /assets/img/blog/argocd.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

## Kiali Install

~~~console
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.24/samples/addons/kiali.yaml

istioctl dashboard kiali
~~~