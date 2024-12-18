---
layout: post
title: 'Microk8s Installation on Windows 11' 
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

- Run the following command from the command line or from PowerShell.

~~~command
Get-ExecutionPolicy
(Restricted가 아닐 경우)  Set-ExecutionPolicy AllSigned 실행 후 Y 입력
~~~

~~~command
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
~~~

~~~command
choco

Chocolatey v2.3.0
Please run 'choco -?' or 'choco <command> -?' for help menu.
~~~

- Windows Home 에디션으로 Hyper-V 비활성
  - [Hyper-V.zip](/assets/doc/Hyper-V.zip) 다운로드/압축해제 후 관리자권한으로 실행
  - [Download Multipass for Windows](https://multipass.run/download/windows)
  - Default 로컬드라이버인 VirtualBox를 Hyper-V로 변경

~~~console
multipass set local.driver=hyperv
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

- code(editor) cloud-init.yaml


~~~console
users:
  - default
  - name: vmuser
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
    - <content of YOUR public key> 
~~~

---

- Ubuntu VM Creation w/ multipass (Using Hyper-V; Windows Hypervisor)
  
~~~console
multipass set local.privileged-mounts=true
multipass launch --name microstack --cpus 4 --memory 8G --disk 30G jammy --cloud-init cloud-init.yaml --mount D:\ssh:/home/ubuntu/ssh
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
sudo microstack init --auto --control --setup-loop-based-cinder-lvm-backend --loop-device-file-size 10

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

- [오픈스택 이미지 다운로드 (.qcow2; for KVM)](https://docs.openstack.org/image-guide/obtain-images.html)

---

### Cirros VM Creation w/Openstack

~~~console
microstack launch cirros --name test
ssh -i /home/ubuntu/snap/microstack/common/.ssh/id_microstack cirros@10.20.20.167

계정 : cirros
암호 : gocubsgo or cubswin:)
~~~

#### Build Cirros Simple Web Server

- 웹 서버 생성
  
~~~console
nohup sh -c "while true; do echo -e 'HTTP/1.0 200 OK\r\n\r\nserver' | sudo nc -l -p 80 ; done" & 
~~~

- 웹 서버 테스트

~~~console
curl 127.0.0.1
~~~

- 추가 볼륨 생성 및 붙이기 (OpenStack에서 볼륨 생성 후 연결)

~~~console
lsblk
df -h
sudo mkfs -t ext4 /dev/vdb
sudo mount /dev/vdb /mnt
~~~