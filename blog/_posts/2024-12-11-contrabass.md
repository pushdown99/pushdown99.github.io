---
layout: post
title: 'Microk8s Installation on Windows 11' 
author: haeyeon.hwang
tags: [microstack, openstack, multipass]
description: >
  Windows 11에서 마이크로 k8s 설치 
image: /assets/img/blog/wordsmith.png
hide_image: true
---


{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## CONTRABASS

### 권장사양

구분|권장사양
---|---
컨트롤러 노드|
. 노드 수|3노드 (권장)
. CPU|24core 이상 (Hyper-Threading 사용은 권장하지 않음)
. MEM|128GB 이상
. DISK|512GB SSD * 2EA, 1TB SSD * 1EA (Repo용)
. NIC|4 x 10Gbps, 4 x 1Gbps (On Board 포함), 4 x 16Gbps 또는 32Gbps FC HBA 또는 10Gbps iSCSI
. Power|듀얼, Hot-Plug, Fully Redundant Power Supply (1+1)
컴퓨트 노드|
. CPU|8core 이상 (Hyper-Threading 사용은 권장하지 않음)
. MEM|512GB 이상
. DISK|256GB SSD * 2ea 이상
. NIC|4 x 10Gbps NIC, 4 x 1Gbps NIC (On Board 포함), 4 x 16/32Gbps FC HBA 또는 10Gbps iSCSI, (별도 백업망 또는 고대역 DB 구성 시) : 4 x 10Gbps NIC
. Power|듀얼, Hot-Plug, Fully Redundant Power Supply (1+1)


구분|기능
---|---
Topology|가상자원 토폴로지, 네트워크 토폴로지, 물리자원 토폴로지, **Rack 실장도, SDS 토폴로지**
장애대응|이벤트 설정 및 알람, Log Insight
모니터링|가상자원 시계열 모니터링, 리포팅
대시보드|가상자원 현황 정보, 호스트 현황 정보, 물리자원 현황 정보, 시스템 정보
GPU 자원 관리|PCI Pass-Through, vGPU, MIG
멀티데이터센터 관리|**Active-Active DR, 멀티 데이터센터 모니터링, 다중 클러스터 관리**
인스턴스 관리|프로비저닝, 인스턴스 Power ON/OFF, 인스턴스 확장, Instant Clone, 오토스케일링, Configuration, 서비스 카탈로그, Affinity Rules, 리소스 고정 할당, 볼륨 타입 관리
스토리지 관리|블록 스토리지 관리, 파일 스토리지 관리, 오브젝트 스토리지 관리, SDS 관리
네트워크 관리|유동 IP 관리, 고정 IP 관리, OVS
백업 및 복구|Volume Backup, 특정 Volume Backup, OS 백업, 실시간 Replication
물리서버 관리|서버 전원 관리, Raid 관리, Disk 관리
마이그레이션|마이그레이션, 라이브 마이그레이션, 라이브 마이그레이션 호환성, ~~스토리지 라이브 마이그레이션, 스위치 간 라이브 마이그레이션, 센터간 라이브 마이그레이션, 이기종 클라우드 간 라이브 마이그레이션~~
고가용성|HA(High availability), HA Restart, HA for PMEM workloads, VM HA, fault tolerance, ~~Proactive HA, Automated UNMAP~~
안정성|Network I/O QoS, Storage I/O Qos, 데이터 복제
운영관리|OKESTRO Tools, SDK  (API 모음), 사용자 관리, 인증 및 인가
보안|감사로그 관리, 암호화된 라이브마이그레이션, 가상머신 암호화, 다중 인증, Trust Authority, ~~데이터센터 간 암호화된 라이브마이그레이션~~
운영 자동화|패키지 관리, 호스트 관리, 일일 점검, OS 관리, 패키지 관리 (SDS)
최적화|Single Reboot Upgrade, Single Root I/O Virtualization(SR-IOV), 가상머신 최적화, 스토리지 최적화
3rd party 연동|3rd party 백업 솔루션 연동(Trilio, Veritas), 3rd party 스토리지(SAN, NAS) 연동
