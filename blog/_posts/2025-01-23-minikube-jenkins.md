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

#### minikube

~~~command
> minikube start

😄  Microsoft Windows 11 Pro 10.0.26100.2605 Build 26100.2605 의 minikube v1.34.0
🎉  minikube 1.35.0 이 사용가능합니다! 다음 경로에서 다운받으세요: https://github.com/kubernetes/minikube/releases/tag/v1.35.0
💡  해당 알림을 비활성화하려면 다음 명령어를 실행하세요. 'minikube config set WantUpdateNotification false'
✨  유저 환경 설정 정보에 기반하여 docker 드라이버를 사용하는 중
📌  Using Docker Desktop driver with root privileges
👍  Starting "minikube" primary control-plane node in "minikube" cluster
🚜  Pulling base image v0.0.45 ...
🔥  Creating docker container (CPUs=2, Memory=4000MB) ...
❗  Failing to connect to https://registry.k8s.io/ from inside the minikube container
💡  To pull new external images, you may need to configure a proxy: https://minikube.sigs.k8s.io/docs/reference/networking/proxy/
🐳  쿠버네티스 v1.31.0 을 Docker 27.2.0 런타임으로 설치하는 중
    ▪ 인증서 및 키를 생성하는 중 ...
    ▪ 컨트롤 플레인을 부팅하는 중 ...
    ▪ RBAC 규칙을 구성하는 중 ...
🔗  bridge CNI (Container Networking Interface) 를 구성하는 중 ...
🔎  Kubernetes 구성 요소를 확인...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  애드온 활성화 : storage-provisioner, default-storageclass
🏄  끝났습니다! kubectl이 "minikube" 클러스터와 "default" 네임스페이스를 기본적으로 사용하도록 구성되었습니다.
~~~


~~~console
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
minikube service argocd-server -n argocd
argocd admin initial-password -n argocd
~~~

1. Create Namespace `argocd`
2. Installation `argocd` to `Kubernetes`
3. Launch a ArgoCD Applications and Services
4. Find out argocd `password`
5. Access a ArgoCD portal with id: `admin`, password

~~~terminal
> kubectl create namespace argocd
namespace/argocd created

> kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

customresourcedefinition.apiextensions.k8s.io/applications.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/applicationsets.argoproj.io created
customresourcedefinition.apiextensions.k8s.io/appprojects.argoproj.io created
serviceaccount/argocd-application-controller created
serviceaccount/argocd-applicationset-controller created
serviceaccount/argocd-dex-server created
serviceaccount/argocd-notifications-controller created
serviceaccount/argocd-redis created
serviceaccount/argocd-repo-server created
serviceaccount/argocd-server created
role.rbac.authorization.k8s.io/argocd-application-controller created
role.rbac.authorization.k8s.io/argocd-applicationset-controller created
role.rbac.authorization.k8s.io/argocd-dex-server created
role.rbac.authorization.k8s.io/argocd-notifications-controller created
role.rbac.authorization.k8s.io/argocd-redis created
role.rbac.authorization.k8s.io/argocd-server created
clusterrole.rbac.authorization.k8s.io/argocd-application-controller created
clusterrole.rbac.authorization.k8s.io/argocd-applicationset-controller created
clusterrole.rbac.authorization.k8s.io/argocd-server created
rolebinding.rbac.authorization.k8s.io/argocd-application-controller created
rolebinding.rbac.authorization.k8s.io/argocd-applicationset-controller created
rolebinding.rbac.authorization.k8s.io/argocd-dex-server created
rolebinding.rbac.authorization.k8s.io/argocd-notifications-controller created
rolebinding.rbac.authorization.k8s.io/argocd-redis created
rolebinding.rbac.authorization.k8s.io/argocd-server created
clusterrolebinding.rbac.authorization.k8s.io/argocd-application-controller created
clusterrolebinding.rbac.authorization.k8s.io/argocd-applicationset-controller created
clusterrolebinding.rbac.authorization.k8s.io/argocd-server created
configmap/argocd-cm created
configmap/argocd-cmd-params-cm created
configmap/argocd-gpg-keys-cm created
configmap/argocd-notifications-cm created
configmap/argocd-rbac-cm created
configmap/argocd-ssh-known-hosts-cm created
configmap/argocd-tls-certs-cm created
secret/argocd-notifications-secret created
secret/argocd-secret created
service/argocd-applicationset-controller created
service/argocd-dex-server created
service/argocd-metrics created
service/argocd-notifications-controller-metrics created
service/argocd-redis created
service/argocd-repo-server created
service/argocd-server created
service/argocd-server-metrics created
deployment.apps/argocd-applicationset-controller created
deployment.apps/argocd-dex-server created
deployment.apps/argocd-notifications-controller created
deployment.apps/argocd-redis created
deployment.apps/argocd-repo-server created
deployment.apps/argocd-server created
statefulset.apps/argocd-application-controller created
networkpolicy.networking.k8s.io/argocd-application-controller-network-policy created
networkpolicy.networking.k8s.io/argocd-applicationset-controller-network-policy created
networkpolicy.networking.k8s.io/argocd-dex-server-network-policy created
networkpolicy.networking.k8s.io/argocd-notifications-controller-network-policy created
networkpolicy.networking.k8s.io/argocd-redis-network-policy created
networkpolicy.networking.k8s.io/argocd-repo-server-network-policy created
networkpolicy.networking.k8s.io/argocd-server-network-policy created

> minikube service argocd-server -n argocd
|-----------|---------------|-------------|--------------|
| NAMESPACE |     NAME      | TARGET PORT |     URL      |
|-----------|---------------|-------------|--------------|
| argocd    | argocd-server |             | No node port |
|-----------|---------------|-------------|--------------|
😿  service argocd/argocd-server has no node port
❗  Services [argocd/argocd-server] have type "ClusterIP" not meant to be exposed, however for local development minikube allows you to access this !
🏃  argocd-server 서비스의 터널을 시작하는 중
|-----------|---------------|-------------|-----------------------|
| NAMESPACE |     NAME      | TARGET PORT |          URL          |
|-----------|---------------|-------------|-----------------------|
| argocd    | argocd-server |             | http://127.0.0.1:3562 |
|           |               |             | http://127.0.0.1:3563 |
|-----------|---------------|-------------|-----------------------|
[argocd argocd-server  http://127.0.0.1:3562
http://127.0.0.1:3563]
❗  windows 에서 Docker 드라이버를 사용하고 있기 때문에, 터미널을 열어야 실행할 수 있습니다

> argocd admin initial-password -n argocd

RqLz4K3bf9nKy10x

 This password must be only used for first time login. We strongly recommend you update the password using `argocd account update-password`.
~~~

1. Login to ArgoCD
2. Applications > `+ New APP`
3. Fill-in

    - (GENERAL) Application Name: `jenkins`
    - (GENERAL) Project Name: `default`
    - (SOURCE) Repository URL: [`https://github.com/pushdown99/argo-jenkins.git`](https://github.com/pushdown99/argo-jenkins.git)
    - (SOURCE) Path: `app`
    - (DESTINATION) Cluster URL: `https://kubernetes.default.svc`
    - (DESTINATION) Namespace: `default`

4. `Create`
5. `SYNC`
6. `kubectl` commands

~~~terminal
> minikube service jenkins-service -n jenkins

|-----------|-----------------|-------------|---------------------------|
| NAMESPACE |      NAME       | TARGET PORT |            URL            |
|-----------|-----------------|-------------|---------------------------|
| jenkins   | jenkins-service |        8080 | http://192.168.49.2:32000 |
|-----------|-----------------|-------------|---------------------------|
🏃  jenkins-service 서비스의 터널을 시작하는 중
|-----------|-----------------|-------------|-----------------------|
| NAMESPACE |      NAME       | TARGET PORT |          URL          |
|-----------|-----------------|-------------|-----------------------|
| jenkins   | jenkins-service |             | http://127.0.0.1:5032 |
|-----------|-----------------|-------------|-----------------------|
🎉  Opening service jenkins/jenkins-service in default browser...
❗  windows 에서 Docker 드라이버를 사용하고 있기 때문에, 터미널을 열어야 실행할 수 있습니다
~~~

~~~terminal
> kubectl get pod -n jenkins | grep jenkins | cut -d' ' -f1

jenkins-7c6f896bf4-452pm

> kubectl -n jenkins exec -it jenkins-7c6f896bf4-452pm -- /bin/bash -c "cat /var/jenkins_home/secrets/initialAdminPassword"

c96863d320e84299b1a51cff74ee5781
~~~

~~~console
> kubectl -n jenkins exec -it jenkins-7c6f896bf4-452pm -- /bin/bash
jenkins@jenkins-7c6f896bf4-452pm:/$ cd /var/jenkins_home
jenkins@jenkins-7c6f896bf4-452pm:~$ mkdir .ssh
jenkins@jenkins-7c6f896bf4-452pm:~$ cd .ssh
jenkins@jenkins-7c6f896bf4-452pm:~/.ssh$ cd /var/jenkins_home
jenkins@jenkins-7c6f896bf4-452pm:~/.ssh$ ssh-keygen -t rsa -b 4096 -C test-key -f github_jenkins
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in github_jenkins
Your public key has been saved in github_jenkins.pub
The key fingerprint is:
SHA256:4Itu7DuptuRBct53PEf9d9LsH2mWd0VlJKEzThZOrzg test-key
The key's randomart image is:
+---[RSA 4096]----+
|            o oo+|
|           o + o.|
|      .     B . .|
|     . .   * + . |
|. o   . S E +   .|
| = . . o . . . o+|
|  +.o.o + .   o*B|
| o.o=. . o    o+=|
| .+=+o          +|
+----[SHA256]-----+
jenkins@jenkins-7c6f896bf4-452pm:~/.ssh$
jenkins@jenkins-7c6f896bf4-452pm:~/.ssh$ ls
github_jenkins  github_jenkins.pub
~~~

4. Register SSH key (public key) to Github Repositories

    - Goto github repositories ([https://github.com/pushdown99/jenkins-webhook](https://github.com/pushdown99/jenkins-webhook))
    - Settings > General/Security/Deploy keys => [`Add deploy key`]
    - Deploy keys/Add new => Title: github_jenkins, Key: (cat github_jenkins.pub) => [`Add key`]

5. Register SSH key (private key) to Jenkins Credentials

    - Goto Jenkins dashboard (ex: http://127.0.0.1:5022)
    - Dashboard > `+ New Item` => New Item / Name: `github_jenkins` Type: `Freestyle project`
    - Dashboard > Name: `github_jenkins` => Source code management => Git/Repository URL: `git@github.com:pushdown99/jenkins-test.git`, Credentials/ Add: `github_jenkins` => Kind: `SSH Username with private key`, Username: `github_jenkins`, Private key/Enterdirectly: (cat github_jenkins) => [`Add`]

6. Build Trigger

    - Build Trigger / [`v`] Github hook trigger for GITScm polling

7. Plugin Installation

    - Jenkins Management > Plugins > Available plugins > `GitHub Integration Plugin` : Install


8. Ngrok Installation (optional: localhost)

