---
layout: post
title: 'Istio Examples' 
author: haeyeon.hwang
tags: [jenkins, github, pipeline, kaniko]
description: >
  Istio Examples
image: /assets/img/blog/argocd.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

## istio examples

[https://istiobyexample.dev/](https://istiobyexample.dev/)

~~~console
istioctl install --set profile=demo -y
~~~

gateway.yaml

~~~yaml
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: hello-gateway
spec:
  selector:
    istio: ingressgateway # use the default IngressGateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "hello.com"
~~~

service.yaml

~~~yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: frontend-ingress
spec:
  hosts:
  - "hello.com"
  gateways:
  - hello-gateway
  http:
  - route:
    - destination:
        host: hello.default.svc.cluster.local
        port:
          number: 80
~~~

~~~console
k apply -f gateway.yaml
gateway.networking.istio.io/hello-gateway created

k apply -f service.yaml
virtualservice.networking.istio.io/frontend-ingress created
~~~