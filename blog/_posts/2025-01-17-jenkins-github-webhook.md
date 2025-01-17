---
layout: post
title: 'Jenkins + Github Web Hook' 
author: haeyeon.hwang
tags: [jenkins, github, webhook]
description: >
  Jenkins + Github Web Hook 
image: /assets/img/blog/argocd.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

## Jenkins

#### k8s jenkins


1. Find a jenkins pod w/ k8s pod, jenkins namespace

~~~bash
kubectl get pod -n jenkins

NAME                       READY   STATUS    RESTARTS      AGE
jenkins-6846f7864d-s92t8   1/1     Running   1 (22m ago)   41m
~~~

2. Login to jenkins pod

~~~bash
kubectl -n jenkins exec -it jenkins-6846f7864d-s92t8 -- /bin/bash
~~~

3. create a ssh key-pair (privae, public)

~~~bash
jenkins@jenkins-6846f7864d-s92t8:/$
jenkins@jenkins-6846f7864d-s92t8:/$ cd /var/jenkins_home
jenkins@jenkins-6846f7864d-s92t8:/$ mkdir .ssh
jenkins@jenkins-6846f7864d-s92t8:/$ cd .ssh
jenkins@jenkins-6846f7864d-s92t8:/$ ssh-keygen -t rsa -b 4096 -C test-key -f github_jenkins
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in github_jenkins
Your public key has been saved in github_jenkins.pub
The key fingerprint is:
SHA256:NJmTn59EOKF/7oLbcUqh1PCJUZ2f82tGL4t7bT8JEKg test-key
The key's randomart image is:
+---[RSA 4096]----+
|          +. .   |
|         B +o    |
|        % o o. . |
|       E @ *  +  |
|        S O +  o |
|       . . * o ..|
|        ..o = o.+|
|        .o.= .o*+|
|        ..o.+o+++|
+----[SHA256]-----+

jenkins@jenkins-6846f7864d-s92t8:~/.ssh$ ls
github_jenkins  github_jenkins.pub
~~~

4. Register SSH key (public key) to Github Repositories

    - Goto github repositories ([https://github.com/pushdown99/jenkins-test](https://github.com/pushdown99/jenkins-test))
    - Settings > General/Security/Deploy keys => [`Add deploy key`]
    - Deploy keys/Add new => Title: github_jenkins, Key: (cat ithub_jenkins.pub) => [`Add key`]

5. Register SSH key (private key) to Jenkins Credentials

    - 

#### ngrok

~~~console
~~~
