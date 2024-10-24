---
layout: post
title: 'Kubernetes' 
author: haeyeon.hwang
tags: [cloud]
description: >
  Kubernetes (k8s) 관련 내용 
image: /assets/img/blog/vSphere.png
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **Kubernetes 개요**

---

#### **k8s Cluster 구조**
- Kubernetes Cluster 컴포넌트 구성

  - 마스터노드
  
    컴포넌트|설명
    ---|---
    etcd|key-value 타입의 저장소</br>쿠버네티스 마스터 및 노드들의 다양한 상태 정보 저장
    kube-apiserver|k8s API를 사용하도록 요청을 받고 요청이 유효한지 검사
    kube-scheduler|파드를 실행할 노드 선택
    kube-controller-manager|파드를 관찰하며 개수를 보장

  - 워커노드
  
    컴포넌트|설명
    ---|---
    kubelet|- 모든 노드에서 실행되는 k8s 에이전트</br>데몬 형태로 동작
    kube-proxy|k8s의 network 동작을 관리</br>iptables rule을 구성
    컨테이너 런타임|컨테이너를 실행하는 엔진</br>docker, containerd, runc

- Kubernetes Cluster 컴포넌트 Overview
  
    ![k8s-cluster-component](/assets/img/blog/k8s-cluster_component.png)  

    Component name|Comunicates with|Role
    ---|---|---
    kube-apiserver|kubectl client(s), Etcd, kube-scheduler, kube-controller-manager,Kubelet, kube-proxy|HTTP REST API로 etcd에 있는 state를 R/W. (이 component만이 직접 Etcd에 접근가능)
    Etcd|kube-apiserver|매 20초간 스케줄링되지 않은 pod들을 읽어오는 API를 kube-apiserver에게 전달. 이후 스케줄링되지 않은 pod들의 property인 nodeName을 변경하여 worker node에 스케줄링
    kube-scheduler|kube-apiserver|API를 polling하고 reconcilation loop를 동작
    kube-controller-manager|kube-apiserver|kube-apiserver에게 20초마다 kubelet이 동작하는 worker node에 스케줄링된 pod spec들을 가져오는 API를 전송하고, local Docker daemon을 실행하여 해당 worker node에 스케줄링된 pod spec을 동작하는 container로 바꿔줌
    kubelet|kube-apiserver and Docker (container runtime)|
    kube-proxy|kube-apiserver|kubernetes의 networking layer를 구현
    Container Engine|kubelet|local Kubelet으로부터 명령어를 받아 container들을 실행

- Master Node 고가용성

#### **Pod 배포**
- Controller Manager - Overview
- Controller Manager - Stateless와 Stateful 개념
- Controller Manager - Deployment
- Controller Manager – Stateful Set
- Controller Manager – DaemonSet
- Controller Manager – Job / CronJob
- Controller Manager – Pod 배포 Flow
- Pod내 Multi Container 구성
- Kubernetes Autoscaler

#### **Storage**
- Container와 Kubernetes Volume 관계
- Kubernetes Volume 특징
- PV & PVC
- PV 및 PVC를 통한 Volume 연결
- PV Lifecycle
- Volume 구분

#### **Networking**
- Pod Network 구성
- CNI (Container Network Interface)
- Pod Network 구성
- Service Network 구성
