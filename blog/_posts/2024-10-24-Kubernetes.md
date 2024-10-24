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
    kube-apiserver|kubectl client(s), Etcd, kube-scheduler, kube-controller-manager,Kubelet, kube-proxy|HTTP REST API로 etcd에 있는 state를 R/W. (**이 component만이 직접 Etcd에 접근가능**)
    Etcd|kube-apiserver|매 20초간 스케줄링되지 않은 pod들을 읽어오는 API를 kube-apiserver에게 전달. 이후 스케줄링되지 않은 pod들의 property인 nodeName을 변경하여 worker node에 스케줄링
    kube-scheduler|kube-apiserver|API를 polling하고 reconcilation loop를 동작
    kube-controller-manager|kube-apiserver|kube-apiserver에게 20초마다 kubelet이 동작하는 worker node에 스케줄링된 pod spec들을 가져오는 API를 전송하고, local Docker daemon을 실행하여 해당 worker node에 스케줄링된 pod spec을 동작하는 container로 바꿔줌
    kubelet|kube-apiserver and Docker (container runtime)|
    kube-proxy|kube-apiserver|kubernetes의 networking layer를 구현
    Container Engine|kubelet|local Kubelet으로부터 명령어를 받아 container들을 실행

- Master Node 고가용성

    ![k8s-master-node-ha](/assets/img/blog/master-node-ha.png)
    [`RAFT 알고리즘`](https://seongjin.me/raft-consensus-algorithm/)

#### **Pod 배포**
- Controller Manager - Overview

    구분|파드유형|워크로드 컨트롤러
    ---|---|---
    고유 데이터 관리/주소 불필요|스테이트리스 Stateless 서버|Deployment
    고유 데이터 관리/주소 필요|스테이트풀 Stateful서버|Statefulset
    백그라운드 프로세스 필요|데몬 서버|DaemonSet
    어떤 처리를 하고 종료|일회성 잡Job 수행 서버|Job
    어떤 처리를 주기적으로 수행|배치성 잡Job 수행 서버|CronJob

- Controller Manager - Stateless와 Stateful 개념

    구분|설명
    ---|---
    Stateless Application|클라이언트와 서버 관계에서, 서버가 클라이언트의 상태를 보존하지 않는 형태의 서비스</br>대표적으로 Apache, Nginx와 같은 Web server Application</br>Stateless 애플리케이션은 쿠버네티스에서 삭제/생성 시 App의 이름과 상관없이 같은 역할을 하는 애플리케이션만 생성</br>쿠버네티스에서는 Replication Controller, Replicaset, Deployment와 같은 컨트롤러를 이용하여 Stateless 파드 관리
    Stateful Application|클라이언트와 서버 관계에서, 서버가 클라이언트의 상태를 보존하는 형태의 Application (대표적으로 DB)

- Controller Manager - Deployment (Stateless App 배포 시 가장 기본인 컨트롤러)

    구분|설명
    ---|---
    디플로이먼트(Deployment)|쿠버네티스가 처음 등장했을 때는 Replication Controller에서 앱을 배포했는데 최근에는 디플로이먼트를 기본적적인 앱 배포에 사용</br>기존 Replication Controller 이나 레플리카셋은 '이력'이라는 개념이 없어 배포 후 애플리케이션 관리에 어려움이 많았음.</br></br>디플로이먼트 장점:</br>- 배포 기능을 세분화하여 레플리카셋에 버전 관리 기능 추가</br>- 파드 개수 유지 기능</br>- 앱을 배포할 때 롤링 업데이트 하거나, 앰 배포 도중 잠시 멈췄다가 다시 배포 기능</br>- 앱 배포 후 이전 버전으로 롤백 기능</br></br>레플리카셋과 완전히 다른 기능이라고 보기는 어렵고, 디플로이먼트가 레플리카셋을 관리하며 앱 배포를 더 세밀하게 관리하는 것이라고 할 수 있음.

- Controller Manager – Stateful Set (Stateful App 배포 시 가장 기본인 컨트롤러), 서버가 클라이언트의 상태를 보존하는 형태의 애플리케이션으로 Mongodb, redis와 같은 Database가 대표적임.

    구분|설명
    ---|---
    Stateful Set|쿠버네티스가 처음 등장했을 때는 Replication Controller에서 앱을 배포했는데 최근에는 디플로이먼트를 기본적적인 앱 배포에 사용</br>기존 Replication Controller 이나 레플리카셋은 '이력'이라는 개념이 없어 배포 후 애플리케이션 관리에 어려움이 많았음.</br></br>디플로이먼트 장점:</br>- 배포 기능을 세분화하여 레플리카셋에 버전 관리 기능 추가</br>- 파드 개수 유지 기능</br>- 앱을 배포할 때 롤링 업데이트 하거나, 앰 배포 도중 잠시 멈췄다가 다시 배포 기능</br>- 앱 배포 후 이전 버전으로 롤백 기능</br></br>레플리카셋과 완전히 다른 기능이라고 보기는 어렵고, 디플로이먼트가 레플리카셋을 관리하며 앱 배포를 더 세밀하게 관리하는 것이라고 할 수 있음.

- Controller Manager – DaemonSet (클러스터 전체 노드에 특정 파드 배포 시 사용)

    구분|설명
    ---|---
    Daemon Set|클러스터 안에 새롭게 노드가 추가되었을 때 데몬셋이 자동으로 해당 노드에 파드를 실행</br>반대로 노드가 클러스터에서 빠졌을 때는 해당 노드에 있던 파드는 그대로 사라질 뿐 다른 곳으로 옮겨가서 실행되지 않음</br></br>단, 특정 노드에만 Pod를 배포할 수 있도록 , Pod의 “node selector”를 이용하여 특정 노드만을 선택할 수 있음</br>**서버의 모니터링이나 로그 수집 용도로 많이 사용**

- Controller Manager – Job / CronJob (실행된 후 종료해야 하는 성격의 작업을 실행시킬 때 사용), 정해진 타이밍에 반복할 Job 실행에 사용

    구분|설명
    ---|---
    Job|하나 이상의 파드를 생성하고 지정된 수의 파드가 성공적으로 종료될 때 까지 계속해서
파드의 실행을 재시도</br>지정된 수 만큼 파드가 성공적으로 완료되면 Job 완료</br>데이터베이스 마이그레이션과 같이 한 번의 잡으로 처리가 끝나는 것에 이용

- Controller Manager – Pod 배포 Flow
    ![k8s-pod-deploy-flow](/assets/img/blog/k8s-pod-deploy-flow.png)

- Pod내 Multi Container 구성

구분|설명
---|---
원칙|✓ 하나의 Pod 내 Multi Container는 서로 다른 종류여야 함</br>✓ Multi Container들은 같은 네트워크 공간을 공유하기 때문에 직접적으로 커뮤니케이션이 가능
특징|Pod 내 컨테이너들은 IP와 Port 공유</br>Pod 내에 배포된 컨테이너 간에는 디스크 볼륨 공유
패턴|Sidecar Pattern,</br>Ambassador Pattern,</br>Adapter Pattern

[✓ 멀티컨테이너 디지이너 패턴](https://gruuuuu.github.io/cloud/design-pattern/): "하나의 컨테이너에는 하나의 책임만 가지고 있어야 한다."

패턴|설명
---|---
Sidecar|메인컨테이너의 기능을 확장 또는 향상, 웹서비스와 로그기능 분리
Ambassador|메인컨테이너의 네트워크기능 담당, 네트워크연결을 담당하는 전용 컨테이너
Adapter|메인컨테이너의 출력을 변환, 모니터링 정보를 제공하는 전용 컨테이너

Q: ISTIO에서 Envoy는 네트워크 기능을 제공하는데 왜 Sidecar Pattern으로 분류하나?
A: Envoy는 단순 네트워크 연결만이 아닌 제어 등에도 관여함.</br>즉, 컨테이너가 어떤 목적을 가지고 메인컨테이너를 보조하는지에 따라 패턴 분류

- Kubernetes Autoscaler

오토스케일러|설명|비고
---|---|---
HPA(Horizontal Pod Autoscaler)|Stateless Application (Scale Out)</br></br>HPA 적용 가능한 Pod 리소스</br>- Deployment</br>- ReplicaSet</br>- Replication Controller</br>- StatefulSet|DaemonSet에는 적용 불가
VPA(Vertical Pod Autoscaler)|Stateful Application  (Scale Up)|
CA(Cluster Autoscaler)||Multi Cloud

  - Kubernetes Autoscaler – HPA 동작

    ![k8s-HPA](/assets/img/blog/k8s-HPA.png)

    단계|설명
    ---|---
    1|Resource Estimator인 cAdvisor가 도커로 부터 메모리와 CPU에 대한 성능 정보를 측정. 이 정보를 kubelet을 통해 가져감
    2|AddOn Component로 metrics-server를 설치하면 metrics-server가 각각의 Node에 있는 kubelet에게 메모리와 CPU 정보를 가져와서 저장  
    3|이 데이터들을 다른 Component들이 사용할 수 있도록 Kube API서버(Resource API)에 등록
    4| HPA는 Kube API서버를 통해 메모리와 CPU 정보를 15초마다 체크하다 Pod의 Resources 사용률이 높아지면 replicaSet의 replicas를 증가시킴
    5|kubectl top 명령어를 통해서 Resource API를 통해서 Pod나 Node의 Resources 상태를 조회
    6|추가적으로 Prometheus를 사용하면 메모리와 CPU 외에도 다른 metric 정보를 수집(패킷 수, Request 양 등)

    ![k8s-HPA2](/assets/img/blog/k8s-HPA2.png)

    HPA 설정 값

    설정값|설명
    ---|---
    속성|sacleTargetRef : Deployment 지정</br>minReplicas : 최소 복제본 개수</br>maxReplicas : 최대 복제본 개수</br>(해당 파드는 minReplicas와 maxReplicas 범위 내의 개수가 생성됨)
    metrics|스케일링 조건

    예제

    구분|설명
    ---|---
    Scale Out|두 Pod의 평균 Requests CPU가 200ms으로 설정되어 있을 때,</br>Type: Resource name: cpu로 설정되어 있기 때문에 AutoScale 기준은 CPU 사용율임</br>Type: Utilization averageUtilization: 50이므로 50% 넘으면 AutoScale 수행됨</br></br>즉, 50%를 실제 CPU 사용량으로 계산 시 200ms * 50% = 100ms이므로 </br>100ms이 넘게 되면 HPA는 replicas를 증가</br>두 Pod의 평균 CPU 사용량이 300ms으로 올라갔을 때, 예상되는 replicas 수는 6개임</br></br>[2(현재 replica수)*300ms(평균 CPU) / 100ms(target(200ms * 50%))] = 6
    Scale In|6개의 Pod가 있는 상태에서 평균 CPU가 50ms으로 떨어지면</br></br>6개 * (50ms / 100ms) = 3개</br>3개 * (50ms / 100ms) = 1.5개 -> 2개(최소 Replica 수)


#### **Storage**
- Container와 Kubernetes Volume 관계

    구분|설명
    ---|---
    개요|✓ 모든 Container는 Container 이미지에서 제공하는 고유하게 분리된 파일 시스템을 가지고 있음</br>=> Container는 언제든 재시작될 수 있고 재시작된 Container는 새로운 Container이므로 기존 파일시스템은 사라짐</br>✓ Container의 기존 파일시스템이 유지되도록 하기 위해서는 Kubernetes Volume을 사용함
    볼륨|✓ 파드 로컬 볼륨 : 파드 안에만 만들어지는 볼륨</br>✓ 노드 로컬 볼륨 : 쿠버네티스 클러스터 노드의 볼륨</br>✓ 네트워크 볼륨 : 클러스터 외부에 존재하는 볼륨

- Kubernetes Volume 특징

    구분|설명
    ---|---
    개요|✓Pod에 종속되는 디스크로 Kubernetes에 의해 관리됨</br>✓ Pod 단위이기 때문에, 그 Pod에 속해 있는 여러 개의 컨테이너가 공유해서 Volume 사용</br>✓ 마운트 방식 : 로컬볼륨(EmptyDir, HostPath)와 네트워크 볼륨(직접지정, PV) 방식</br>✓ 로컬볼륨과 직접지정방식 모두 서비스 연속성 이슈 및 운영자에 의존성을 가지고 있어 PV 방식 선호
    볼륨|✓ emptyDir 볼륨 : 노드의 디스크에 생성 (메모리에 저장하는 tmpfs로도 생성 가능)파드가 삭제되면 볼륨과 이에 저장된 파일들 삭제</br>✓ hostPath 볼륨 : 노드의 파일 시스템 마운트</br>- 파드가 삭제되어도 볼륨에 저장된 파일들은 그대로 존재</br>- 노드의 파일 시스템을 마운트하기 때문에 파드가 다른 노드로 스케줄링 되면 이전 데이터를 볼 수 없음

    구분|사용목적|파드 삭제시 볼륨 폐기|볼륨 유형
    ---|---|---|---
    어플리케이션|어떤 처리를 위한 임시 공간|Y|파드 로컬 볼륨
    -|컨피그맵, 시크릿, 파드 정보 참조|Y|파드 로컬 볼륨
    -|파드가 실행된 노드의 파일 접근|N|노드 로컬 볼륨
    -|특정 노드의 파일 접근|N|노드 로컬 볼륨
    -|클러스터 외부 스토리지의 파일 접근|N|네트워크 볼륨
    데이터베이스|컨피그맵, 시크릿, 파드 정보 참조|Y|파드 로컬 볼륨
    -|파드가 실행된 노드에만 데이터 저장간|ㅜ|노드 로컬 볼륨
    -|특정 노드에만 데이터 저장|N|노드 로컬 볼륨
    -|클러스터 외부 스토리지에 데이터 저장|N|노드 로컬 볼륨

- PV & PVC

개요|설명
---|---
개요|✓ 쿠버네티스에 애플리케이션을 배포하는 개발자는 어떤 종류의 스토리지 기술이 사용되는지 알 필요가 없어야 함</br>✓ 개발자가 운영자에 의존성을 가지지 않고 필요한 스토리지를 직접 Kubernetes에 요청하기 위해 PV 및 PVC 개념
PV</br>(퍼시스턴트 볼륨)|운영자는 미리 설정한 스토리지 볼륨을 Kubernetes에서 사용 가능한 Persistent Volume으로 구성
PVC</br>(퍼시스턴트 볼륨 클레임)|개발자가 어플리케이션에 필요한 용량 및 속성 요청

![k8s-PV](/assets/img/blog/k8s-PV.png)

- PV 및 PVC를 통한 Volume 연결

구분|설명
---|---
생략 가능한 항목|labels (사용 시 PVC의 Selector 항목에서 사용됨)</br>storageClassName (사용 시 PVC와 동일해야 함)</br>persistentVolumeReclaimPolicy</br>volumeMode
PV와 매칭되기 위한 조건|사용 시 바인딩 할 퍼시스턴트 볼륨 오브젝트의 값과 동일해야 함 (생략가능)</br>볼륨 요청 크기는 바인딩 할 PV에 지정한 용량보다 같거나 작아야 함 (PV와 PVC는 반드시 1:1로 매핑)</br>PV와 동일해야 함</br>사용 시 바인딩하고 싶은 PV의 labels와 동일해야 함(생략 가능)

- PV Lifecycle
- Volume 구분

$\left\lvert \frac{s^2+1}{s^3+2s^2+3s+1} \right\rvert$

#### **Networking**
- Pod Network 구성
- CNI (Container Network Interface)
- Pod Network 구성
- Service Network 구성
