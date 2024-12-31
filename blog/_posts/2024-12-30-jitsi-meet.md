---
layout: post
title: 'Jitsi-Meet' 
author: haeyeon.hwang
tags: [k8s, kubernetes]
description: >
  Jitsi-Meet 
image: /assets/img/blog/kubernetes.png.png
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## [Jitsi-Meet](https://jitsi.github.io/handbook/docs/dev-guide/dev-guide-web-jitsi-meet/)

- Using `Ubuntu 20.04.5 LTS 설치`
- How-To Installation

- Windows

~~~console
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.profile
nvm install 18
sudo apt update
sudo apt install build-essential

git clone https://github.com/jitsi/jitsi-meet
cd ./jitsi-meet
npm install
make
make dev
~~~

- Linux

~~~console
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.profile
nvm install 18
sudo apt update
sudo apt install build-essential

git clone https://github.com/jitsi/jitsi-meet
cd ./jitsi-meet
npm install
make
sudo apt install debhelper
dpkg-buildpackage -A -rfakeroot -us -uc -tc
make dev
~~~

[!NOTE]
Information the user should notice even if skimming.

