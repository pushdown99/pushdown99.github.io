---
layout: post
title: 'vSphere 인프라 설계' 
author: haeyeon.hwang
tags: [cloud, VMware, vSphere]
description: >
  vSphere 관련 내용 
image: /assets/img/blog/realtor.jpg
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **vSphere를 이용한 목표시스템 설계**

#### **설계**

목표 시스템 및 설계를 위한 고려사항 검토</br>
목표시스템의 인프라가 정상적으로 구성되고 운영될 수 있도록 반드시 필요한 요소 점검</br>
하드웨어 사양 도출: 필요한 자원의 양을 절차에 맞게 산정하여 적절한 하드웨어 사양을 도출

고려사항</br>
  - 서버 및 클러스터
    - VM 및 vCenter를 수용하기 위한 적정 사양
    - 성능 및 가용성을 위한 예비율 고려
    - 적절한 클러스터 구성
  
  - 네트워크
    - 인프라 구성에 필요한 논리적 네트워크 개수(VLAN)
    - 인프라 구성에 필요한 IP 주소 수량
    - 논리 인터페이스 구성
    - 물리적인 네트워크 연결 수량
    - 스토리지 네트워크
  
  - 스토리지
    - 데이터 스토어 용량 및 수량
  
  - 인프라
    - DNS 사용 필수

---  


1) VM 요구사항 기술: 고객 및 시스템 요구사항을 취합하여 시스템 목록 및 필요한 자원을 나열
  
    VM|OS|CPU(core)|메모리(GB)|디스크(GB)|비고
    ---|---|---|---|---|---
    Web#1|Linux|4|8|100<td rowspan="2">평균 사용율 20% / 피크 50%</td>
    Web#2|Linux|4|8|100|
    WAS#1|Linux|8|16|200<td rowspan="2">평균 사용율 30% / 피크 70%</td>
    WAS#2|Linux|8|16|200|
    DB#1|Windows|12|64|500<td rowspan="2">실시간 데이터 처리 성능이 반드시 보장되야 함</td>
    DB#2|Windows|12|64|500|
    AD|Windows|4|8|100|평균 사용율 10%
    NTP|Linux|2|4|50|평균 사용율 5%
    vCenter|vAppliance|4|19|700|Small Size

2) 가상화 비율 / 자원 예비율 산정

    - 가상화 자원 산정 방식

    시스템|CPU(core)|평균사용량(%)|메모리(GB)|평균사용량(GB)
    ---|---|---|---|---
    서버#1|1|15%|8|2
    서버#2|1|40%|8|4
    서버#3|2|55%|16|6
    서버#3|2|30%|16|3
    합계|6|<u>2.25</u>|48|15

    가상화를 통한 효율적인 자원 사용|주요 장점
    ---|---
    기존 시스템 자원의 총합 = 6Core / 48GB</br>가상화 전환 시 최소 3Core / 16GB 사양으로 수용 가능|시스템 사양/수량 감소</br>자원증설 및 확장 용이 (필요 시, 가상자원 추가할당)</br>시스템 구성시간 단축 (하드웨어 구성단계 생략)</br>운영효율성 증가 (vMotion/HA 등)


    - 가상화 자원 산정 순서
      - 가상화 대상 시스템의 평균 사용량 수집 또는 추정(공유 자원 요구량)
      - Peak상황 및 자원 경합 발생을 대비한 예비율 산정(예비율)
      - 자원을 반드시 100% 할당 해야 하는 시스템 구분(전용 자원 요구량)

    - 가상화 자원 요구량 계산 공식
      - <u>가상화 자원 요구량 = (공유 자원 요구량 * 예비율) + 전용 자원 요구량</u>

    자원을 공유하는 시스템|자원을 전용하는 시스템</br>(자원 경합시 반드시 성능이 유지되야 하는 시스템)
    ---|---
    (1) 평소 사용율이 낮은 시스템 -> 개발계, 단순 파일 전송 등</br>(2) 특정한 시간에만 바쁜 시스템 -> 쇼핑몰, 수강신청, 회계 등</br>(3) 작업이 느려도 크게 문제 없는 시스템 -> 우선순위 낮은 배치, 회계 등|(1) 실시간성 데이터 처리 -> 영상 및 음성 실시간 처리/Database등</br>(2) 처리량/성능에 민감 -> 주어진 시간안에 처리가 끝나야 하는 배치 등

   - 가상화 비율 (CPU): 자원 사용율 수집 / 추정 불가 시 통상적으로 사용
  
        pCPU:vCPU 비율|적용 대상|비고
        ---|---|---
        1:1|고성능/실시간처리<td rowspan="3">VM의 용도확인 후 개별 적용</td>
        1:3|일반 
        1:5|낮은 사용량

   - 가상화 비율 (메모리)
  
        pMEM:vMEM 비율|적용 대상|비고
        ---|---|---
        1:1|전체 VM|성능 이슈를 피하기 위해 특수한 경우 외에는 1:1

   - 가상화 비율 (디시크)
  
        pDISK:vDISK 비율|적용 대상|비고
        ---|---|---
        1:1|전체 VM|용량부족 이슈를 피하기 위해 특수한 경우 외에는 1:1

   - 자원 예비율 (예비율은 통상적으로 고객사 정책에 따름)
  
        자원 예비율|적용 대상|비고
        ---|---|---
        20%|사용량 편차가 적음 (개발 서버 등)<td rowspan="3">VM의 용도확인 후 개별 적용</td>
        30%|일반|
        40%|시간대 별 사용량 편차가 큼|

   - 장애 예비율 (예비율은 통상적으로 고객사 정책에 따름)
  
        케이스|장애 예비율|비고
        ---|---|---
        3 Host 클러스터|50%|1대 장애 -> 나머지 2대에서 수용
        4 Host 클러스터|33%|1대 장애 -> 나머지 3대에서 수용
        5 Host 클러스터|25%|1대 장애 -> 나머지 4대에서 수용
        6 Host 클러스터|11%|1대 장애 -> 나머지 5대에서 수용

        ** 서버 사양에 근접하는 크기를 가진 고사양 가상머신이 있는 경우 별도 호스트 추가 권고</br>
        예: 10Core/64GB 호스트에 8Core/48GB VM이 있는 경우 예비율을 적용하더라도 수용 가능한 호스트가 없을 수 있음
        

3) 클러스터 설계
  - 클러스터 설계를 위해 가상머신 자원 총량을 계산
  
    VM|OS|CPU(core)|가상화비율(core)|자원예비율|최종 core|메모리(GB)|디스크(GB)
    ---|---|---|---|---|---|---|---
    Web#1|Linux|4|1:3|30%|1.716|8|100
    Web#2|Linux|4|1:3|30%|1.716|8|100
    WAS#1|Linux|8|1:3|40%|3.696|16|200
    WAS#2|Linux|8|1:3|40%|3.696|16|200|
    DB#1|Windows|12|1:1|0%|12|64|500
    DB#2|Windows|12|1:1|0%|12|64|500
    AD|Windows|4|1:5|20%|0.96|8|100
    NTP|Linux|2|1:5|20%|0.48|4|50
    vCenter|vAppliance|4|1:3|30%|1.716|19|700
    합계||58|||37.98|207|2450

    - 가상화 비율 1:1인 서버는 실제 자원 사용량과 무관하게 자원을 전용하는 시스템 이므로 별도 예비율을 산정하지 않음 
    - 증설 필요시 vCPU 추가할당
    - 위 표는 기존 시스템의 사용율을 수집/추정할 수 없어 통상적인 기준으로 가상화 비율 산정 하는 상황을 가정함
    - 모니터링 데이터가 있는 경우 실제 사용량을 가상화 비율에 입력

  - 계산된 자원을 몇 대의 Host에 분리할지 정의
    
    최종 Core|메모리|디스크
    ---|---|---
    37.98 core|207 GB|2450 GB

  - ESXi 오버헤드
    
    CPU|메모리|디스크
    ---|---|---
    물리 CPU의 5%|최소 8GB (운영 12GB)|통상 수십 GB 이내

  - Host 수량에 따른 추가 자원 요구량
    
    Host 수량|가용성 예비율|CPU 오버헤드|메모리 오버헤드
    ---|---|---|---
    3|50%|5%|24
    4|33%|5%|32
    5|25%|5%|40

  - VMware ESXi
    
    구분|Host 수량 증가 (+)|Host 수량 감소 (-)
    ---|---|---
    장점|더욱 효율적인 자원 분산 가능</br>장애 예비율로 인한 오버헤드 감소</br>DB/OS등 라이선스 활용에 유리하도록 다중 클러스터 구성 가능|하드웨어 수량 감소에 따른 구매/상면 비용 감소</br>개별 서버의 사양이 높아짐(증설 시 유리)
    단점|하드웨어 수량 증가에 따른 구매/상면 비용 증가</br>개별 서버의 사양이 낮아짐(증설시 불리함)|장애 예비율로 인한 오버헤드 증가</br>비효율적인 자원분산 (비대한 VM이 있을 경우 한쪽 호스트에 쏠림 현상)</br>다중 클러스터 구성 불가, SW/OS의 라이선스 비용 증가 가능성

4) 총 자원 요구량 계산
   
  - VM 자원 사용량
    
    Host 수량|가상머신 요구량</br>CPU|</br>메모리|가용성예비율</br>CPU|</br>메모리|오버헤드</br>CPU|</br>메모리|총자원요구량</br>CPU|</br>메모리|**하드웨어요구량**</br>CPU|</br>메모리|
    ---|---|---|---|---|---|---|---|---|---|---
    3 Host|37.89|207|18.945 (50%)|103.5%(50%)|3.6GHz|24GB|67.77|334.5|72|340
    4 Host|37.89|207|12.504 (33%)|68.3%(33%)|4.0GHz|32GB|66.51|308.3|80|310
    5 Host|37.89|207|9.473 (25%)|51.75%(25%)|4.0GHz|40GB|67.48|298.8|80|300

  - 스토리지 요구량 산정: 스토리지는 데이터 증가를 고려하여 용량 산정, 통상적인 기준보다는 고객사 요구사항 기준으로 사이징
    
    디스크|예비율|연간 증감치|**총 자원요구량**
    ---|---|---|---
    2450 GB|30%|연 5% x 5년|4065 GB

5) 하드웨어 사양 정의

  - VM 자원 사용량
    
    Host 수량|총자원요구량</br>CPU|</br>메모리|**하드웨어요구량**</br>CPU|</br>메모리|**개별서버 최소 사양**</br>CPU|</br>메모리
    ---|---|---|---|---|---|---
    3 Host|67.77|334.5|68|340|23 core|114 GB

    - <u>12Core CPU * 2EA / 128GB 시스템 구성 선택</u>
      - NIC 2중화, HBA 2중화 고려
      - 시판중인 CPU/Memory 로 구성 가능한 요구사항에 가장 근접한 Spec
      
        참조|사이트 링크
        ---|---
        CPU|[https://ark.intel.com/content/www/us/en/ark/products/series/228622/4th-generation-intel-xeon-scalable-processors.html](https://ark.intel.com/content/www/us/en/ark/products/series/228622/4th-generation-intel-xeon-scalable-processors.html)
        MEM|[https://www.cisco.com/c/dam/en/us/products/collateral/servers-unified-computing/ucs-c-series-rack-servers/c220-c240-x210c-x410c-m7-memory-guide.pdf](https://www.cisco.com/c/dam/en/us/products/collateral/servers-unified-computing/ucs-c-series-rack-servers/c220-c240-x210c-x410c-m7-memory-guide.pdf)
  
    - CPU 선정 -> 동일 Core구성시 1CPU / 2CPU 판단 기준
      - 1CPU : 인터페이스 수량이 적을 때, CPU 단위 라이선스 SW 비용을 줄이고자 할 때
      - 2CPU : 더 많은 CPU Core / 메모리 / 연결되는 PCI-E장치가 많을 때

    - 메모리 선정
      - 벤더에서 제공하는 권장 메모리 구성을 참조하여 가장 근사한 값 선택