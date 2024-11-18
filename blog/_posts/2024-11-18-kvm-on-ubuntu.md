---
layout: post
title: 'vagrant' 
author: haeyeon.hwang
tags: [Ubuntu, KVM]
description: >
  우분투에서 KVM 가상화 환경 설치 관련 내용 
image: /assets/img/blog/vSphere.png
hide_image: true
---

## 우분투 환경에서의 KVM 가상화 환경 설치

### 가상화 지원여부 확인

~~~console
lscpu | grep Virtulization
~~~

### 필요 패키지 설치

구분|설명
---|---
qemu-kvm|KVM 하이퍼바이저 에뮬레이션 제공
libvirt-daemon-syste,