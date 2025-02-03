---
layout: post
title: 'Network Bridge' 
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


~~~console
netsh bridge show adapter


----------------------------------------------------------------------------------------------------------------
 IfIndex GUID                                    Adapter Name                 IsBridged Bridgeable Compatibility
----------------------------------------------------------------------------------------------------------------
 24      {4C589BED-FB1D-4E1E-9B93-92DC5FEDE95A}  vEthernet (Default Switch)      Yes    Yes         disabled
 14      {7DF3E725-057E-4B58-9AC9-D4E651A7D0B9}  이더넷                             Yes    Yes         disabled
 22      {E45747A3-6F21-4628-9E27-725FEC048449}  Bluetooth 네트워크 연결                No    Yes         disabled
 4       {1AD7E501-2D0B-4741-9F8E-F034AA542213}  Wi-Fi                            No    Yes         disabled
----------------------------------------------------------------------------------------------------------------

netsh bridge create 24 14

~~~