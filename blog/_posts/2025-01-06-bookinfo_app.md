---
layout: post
title: 'Bookinfo Application, Istio' 
author: haeyeon.hwang
tags: [k8s, istio]
description: >
  Bookinfo Application, Istio
image: /assets/img/blog/wordsmith.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}


## [Bookinfo Application](https://istio.io/latest/docs/examples/bookinfo/)

The end-to-end architecture of the application is shown below.


![bookinfo application without istio](/assets/img/blog/bookinfo_without_istio.png)

---
---

### Before you begin

~~~console
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml; }
~~~

~~~console
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml

customresourcedefinition.apiextensions.k8s.io/gatewayclasses.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/gateways.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/grpcroutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/httproutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/referencegrants.gateway.networking.k8s.io created
~~~

~~~console
kubectl get crd gateways.gateway.networking.k8s.io

NAME                                 CREATED AT
gateways.gateway.networking.k8s.io   2025-01-07T06:27:37Z
~~~

---

### Deploying the application

![bookinfo application](/assets/img/blog/bookinfo_with_istio.png)

---

#### Start the application services

Change directory to the root of the Istio installation.

The default Istio installation uses automatic sidecar injection. Label the namespace that will host the application with istio-injection=enabled:

~~~console
kubectl label namespace default istio-injection=enabled

namespace/default labeled
~~~

Deploy your application using the `kubectl` command:

~~~console
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

service/details created
serviceaccount/bookinfo-details created
deployment.apps/details-v1 created
service/ratings created
serviceaccount/bookinfo-ratings created
deployment.apps/ratings-v1 created
service/reviews created
serviceaccount/bookinfo-reviews created
deployment.apps/reviews-v1 created
deployment.apps/reviews-v2 created
deployment.apps/reviews-v3 created
service/productpage created
serviceaccount/bookinfo-productpage created
deployment.apps/productpage-v1 created
~~~

Confirm all services and pods are correctly defined and running:

~~~console
kubectl get services

NAME          TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE
details       ClusterIP   10.0.0.31    <none>        9080/TCP   6m
kubernetes    ClusterIP   10.0.0.1     <none>        443/TCP    7d
productpage   ClusterIP   10.0.0.120   <none>        9080/TCP   6m
ratings       ClusterIP   10.0.0.15    <none>        9080/TCP   6m
reviews       ClusterIP   10.0.0.170   <none>        9080/TCP   6m
~~~

and

~~~console
kubectl get pods

NAME                             READY     STATUS    RESTARTS   AGE
details-v1-1520924117-48z17      2/2       Running   0          6m
productpage-v1-560495357-jk1lz   2/2       Running   0          6m
ratings-v1-734492171-rnr5l       2/2       Running   0          6m
reviews-v1-874083890-f0qf0       2/2       Running   0          6m
reviews-v2-1343845940-b34q5      2/2       Running   0          6m
reviews-v3-1813607990-8ch52      2/2       Running   0          6m
~~~

To confirm that the Bookinfo application is running, send a request to it by a curl command from some pod, for example from ratings:
~~~console
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

<title>Simple Bookstore App</title>
~~~

---

#### Determine the ingress IP and port

Create a gateway for the Bookinfo application: (Istio API)

~~~console
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml

gateway.networking.istio.io/bookinfo-gateway created
virtualservice.networking.istio.io/bookinfo created
~~~

Confirm the gateway has been created:

~~~console
kubectl get gateway

NAME               AGE
bookinfo-gateway   32s
~~~

2. Set GATEWAY_URL:

~~~console
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
~~~

---

### Confirm the app is accessible from outside the cluste

To confirm that the Bookinfo application is accessible from outside the cluster, run the following `curl` command:

Istio APIs

~~~console
kubectl apply -f samples/bookinfo/networking/destination-rule-all.yaml
~~~


---

~~~console
kubectl get destinationrules -o yaml
~~~