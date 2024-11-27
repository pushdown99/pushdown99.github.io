---
layout: post
title: 'Microstack Installation on Windows 11' 
author: haeyeon.hwang
tags: [microstack, openstack, multipass]
description: >
  Windows 11에서 오픈스택(마이크로스택) 설치 
image: /assets/img/blog/wordsmith.png
hide_image: true
---

## Microstack Installation on Windows 11

### Installation

#### [Chocolatey (choco)](https://chocolatey.org/) 설치

- Window Powershell 관리자 권환으로 실행
~~~command
Get-ExecutionPolicy
~~~

- Restricted가 아닐 경우,  Set-ExecutionPolicy AllSigned 실행 후 Y 입력

~~~command
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityPro
~~~

~~~command
choco

Chocolatey v2.3.0
Please run 'choco -?' or 'choco <command> -?' for help menu.
~~~

#### [Multipass](https://multipass.run/) 설치

- [Choco로 Multipass 설치하기](https://community.chocolatey.org/packages/multipass)

~~~command
choco install multipass
~~~

#### Microstack Installation

- Ubuntu VM Creation w/ multipass (Using Hyper-V; Windows Hypervisor)
  
~~~console
multipass launch --name microstack --cpus 4 --memory 8G --disk 30G jammy
~~~

구분|설명
---|---
Name|Ubuntu VM name
cpus|Core 개수 (4)
memory|메모리 크기 (8G)
disk|블록스토리지 (30G)
-|Ubuntu distro (jammy)

- Hyper-V 관리자
  
![hyperv_manager.png](/assets/img/blog/hyperv_manager.png)

- Login to Ubuntu VM

~~~console
multipass shell microstack
~~~

- Microstack Installation
  
~~~console
sudo snap install microstack --devmode --edge
~~~

- Microstack Initialization
  
~~~console
sudo microstack init --auto --control
~~~

### Openstack Dashboard Connection

- ip address 확인하기
  
~~~console
sudo apt install net-tools

ifconfig -a

sudo snap get microstack config.credentials.keystone-password
~~~

- PC Browser에서 Openstack Dashboard 접근
  - admin
  - password

![openstack_dashboard.png](/assets/img/blog/openstack_dashboard.png)
