---
layout: post
title: 'Harbor Installation, Push/Pull' 
author: haeyeon.hwang
tags: [harbor, pull, push]
description: >
  Harbor Installation, Push/Pull 
image: /assets/img/blog/argocd.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

## Harbor Installation, Push, Pull

expose.type: loadBalancer
expose.tls.enabled: false

~~~yaml
expose:
  type: loadBalancer
  ports:
    httpPort: 80
  tls:
    enabled: false # true

externalURL: http://core.harbor.localhost
~~~

~~~console
kubectl create ns hb
helm install harbor -f values.yaml . -n hb
minikube tunnel
~~~

browse to `http://localhost`
id: `admin`, password: `Harbor12345`

~~~console
docker login core.harbor.localhost
~~~
id: `admin`, password: `Harbor12345`

~~~console
docker pull pushdown99/myweb1
docker tag pushdown99/myweb1:latest core.harbor.localhost/library/myweb1:latest
docker push core.harbor.localhost/library/myweb1:latest
~~~
