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
jenkins@jenkins-7c6f896bf4-h44rq:~$ cd workspace
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

~~~console
mkdir .ssh
ssh-keygen -t rsa -f .ssh/my-jenkins-github-key
~~~

~~~console
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6bOq0Pm8jDD10R9SV0PZN0VTudKrSBR9T+UB7H6MGHet3t/M4p5zpWqUQaElJ25N6jx83QS3o9vvMnYfoPLsIQPsxFtJVb7eKqG5mMsXtWl+vBNfQpWfWNdFkzu4D5vcdcYqFxmR4TiBzhGF+TOLaw5Yy+ZqOoYMgFlbqW+dfchnfMe/wE9aSa5EeLrMN+1kR2wv/IEWK+QE1xZ2zVKsuJDNAijp0nx18OA6kkoZHM4gOwPsG+UaQ5+/KMZYmm0RQ0UU/76WgUjBNxlvjFxnzqHzFJnqb1cRt5FEoO9lcfMFctTTScFiExXZDS7OdUxkDHcU7ynAih3wHWasoRVUtp7uRf9jBP8objcdAi7dvxsfedgVcBWc4ZQpL5J7y0MyewCAY81iRpyFgFTFGLFoH8VEKN0wqJySfqWiX3A+u2NsaVMPJokJZZo7ZNb/o9UffsjpRSJazlBH9Dkj/Z4ITkic61XS9O6i0P+job7tc6rVwWZFWE3uUilvkdARLb+k= root@jenkins-7c6f896bf4-7lwc7
~~~

~~~console
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
~~~