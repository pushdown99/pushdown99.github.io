---
layout: post
title: 'Jenkins Pipeline' 
author: haeyeon.hwang
tags: [jenkins, github, pipeline]
description: >
  Jenkins Pipeline 
image: /assets/img/blog/argocd.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

---

## Jenkins


~~~console
pipeline {
    agent any

    stages {
        stage('github clone') {
            steps {
                git branch: 'main', url: 'https://github.com/pushdown99/jenkins-hello-world.git'
            }
        }
    }
}
~~~

~~~console
kubectl get pod -n jenkins

NAME                       READY   STATUS    RESTARTS   AGE
jenkins-7c6f896bf4-h44rq   1/1     Running   0          18m
~~~

~~~console
kubectl -n jenkins exec -it jenkins-7c6f896bf4-h44rq -- /bin/bash

jenkins@jenkins-7c6f896bf4-h44rq:/$
~~~

~~~console
jenkins@jenkins-7c6f896bf4-h44rq:~$ cd /var/jenkins_home/workspace
jenkins@jenkins-7c6f896bf4-h44rq:~/workspace$ cd hello-world
jenkins@jenkins-7c6f896bf4-h44rq:~/workspace/hello-world$ ls

Jenkinsfile  README.md
~~~

~~~console
FROM jenkins/jenkins:lts
USER root
RUN apt-get update
RUN apt-get install -y build-essential sudo net-tools iputils-ping
RUN echo 'root:Docker!' | chpasswd
~~~

~~~console
pipeline {
    agent { docker { image 'node:22.13.0-alpine3.21' } }
    stages {
        stage('build') {
            steps {
                sh 'node --version'
            }
        }
    }
}
~~~