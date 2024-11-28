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

- SSH Key Creation (at windows powershell or command terminal)
  
~~~console
ssh-keygen -C ubuntu -f multipass-ssh-key
touch cloud-init.yaml
~~~

~~~console
code cloud-init.yaml

users:
  - default
  - name: vmuser
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
    - <content of YOUR public key> 
~~~

- Ubuntu VM Creation w/ multipass (Using Hyper-V; Windows Hypervisor)
  
~~~console
multipass launch --name microstack --cpus 4 --memory 8G --disk 30G jammy --cloud-init cloud-init.yaml
~~~

- Hyper-V 관리자
  
![hyperv_manager.png](/assets/img/blog/hyperv_manager.png)

- Login to Ubuntu VM

~~~console
multipass shell microstack
~~~

- Microstack Installation (at Ubuntu VM)
  
~~~console
sudo snap install microstack --devmode --beta
udo microstack init --auto --control --setup-loop-based-cinder-lvm-backend --loop-device-file-size 10

sudo tee /var/snap/microstack/common/etc/cinder/cinder.conf.d/glance.conf <<EOF
[DEFAULT]
glance_ca_certificates_file = /var/snap/microstack/common/etc/ssl/certs/cacert.pem
EOF

sudo snap restart microstack.cinder-{uwsgi,scheduler,volume}
sudo snap alias microstack.openstack openstack
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

### Cirros VM Creation w/Openstack

~~~console
microstack launch cirros --name test
ssh -i /home/ubuntu/snap/microstack/common/.ssh/id_microstack cirros@10.20.20.167

계정 : cirros
암호 : gocubsgo
~~~
