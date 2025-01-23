---
layout: post
title: 'Jenkins Kaniko' 
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

## Jenkins + Kaniko

[https://seokbin.tistory.com/10](https://seokbin.tistory.com/10)

~~~console
podTemplate(yaml: '''
              kind: Pod
              metadata:
                name: kaniko-image-build-pod
              spec:
                containers:
                - name: yq
                  image: [harbor-repo]/docker-local/yq
                  imagePullPolicy: Always
                  tty : true
                  command:
                  - sleep
                  args:
                  - 99d
                - name: kaniko
                  image: gcr.io/kaniko-project/executor:v1.6.0-debug
                  imagePullPolicy: Always
                  command:
                  - sleep
                  args:
                  - 99d
                  volumeMounts:
                    - name: docker-config
                      mountPath: /kaniko/.docker
                  tty: true
                volumes:
                    - name: docker-config
                      configMap:
                        name: docker-config-harbor
'''
  ) {

  node(POD_LABEL) {
    stage('Build with Kaniko') {

      //git tag를 가져오기 위한 clone 
      git branch: 'main',
        credentialsId: 'github-credential',
        url: 'https://github.com/matildalab-private/gcmp-api.git'

      script(){
          GIT_TAG = sh (
            script: 'git describe --always',
            returnStdout: true
          ).trim()
      }
            //Image build 
      container('kaniko') {
        //kaniko 에서 빌드하기 위해 소스코드 clone
        git branch: 'main',
          credentialsId: 'github-credential',
          url: 'https://github.com/matildalab-private/gcmp-api.git'
        sh 'mkdir manifests'
        sh 'chmod 777 -R manifests'

        dir("manifests"){
          //dockerfile이 포함된 repository clone
          git branch: 'main',
            credentialsId: 'github-credential',
            url: 'https://github.com/matildalab-private/matilda-helm-for-CD'
        }
        // kaniko 실행
        sh '/kaniko/executor -f `pwd`/manifests/gcmp-api/Dockerfile -c `pwd` --insecure --skip-tls-verify --cache=true --destination=[harbor-repo]/docker-local/gcmp-api:' + GIT_TAG
      }

    }
  }
}
~~~