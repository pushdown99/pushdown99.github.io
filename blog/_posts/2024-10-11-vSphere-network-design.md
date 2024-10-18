---
layout: post
title: 'vSphere 네트워크 설계' 
author: haeyeon.hwang
tags: [cloud, VMware, vSphere, Network]
description: >
  vSphere 관련 내용 
image: /assets/img/blog/vSphere.png
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **vSphere를 이용한 목표시스템 네트워크 설계**

#### **VMware의 Best Practices에 따른 네트워크 설계**

구분|네트워크 설계
---|---
논리네트워크 구분|VM이 사용하는 트래픽과 ESXi 서비스를 위한 트래픽으로 분리</br>ESXi가 사용하는 트래픽은 용도별로 다른 VLAN / 인터페이스 권장</br>관리/vMotion/VM 트래픽은 반드시 별도 VLAN으로 분리
가상스위치 설계|가상스위치 분리 = 업링크 그룹 분리, 표준스위치/분산스위치 선택</br>VLAN을 그루핑하여 가상스위치와 매핑, 고려사항 : 용도 or 트래픽 양</br>Vmk 어댑터 : ESXi가 외부와 통신을 하기위한 논리 인터페이스
업링크설계|트래픽 중요도에 따라 단일 업링크 or 이중화, MTU 설계</br>A/A, A/S, Failover순서, 트래픽 로드밸런싱 구성</br>물리 스위치와 포트맵 작성
[참고] 트래픽 세이핑|물리적인 네트워크 연결을 무한정 늘릴수 없으므로 네트워크별 트래픽 한계 지정</br>vSwitch 및 포트그룹별 평균/최대 대역폭 지정 가능</br>분산스위치의 [NIOC(Network I/O Control)](https://docs.vmware.com/kr/VMware-vSphere/8.0/vsan-network-design-guide/GUID-6B00B437-53A3-4ACD-8CD7-AC9D0CE5BA8E.html) 기능을 쓰는경우 시스템 트래픽을 종류 별로 제한 가능


1. 논리 네트워크 구분

    네트워크 구분|VLAN ID|비고
    ---|---|---
    관리|100|ESXi 하이퍼바이저 관리용
    vMotion|200|vMotion 트래픽 전용
    iSCSI 스토리지|300|공유 스토리지 연결
    VM Network#1|800|가상머신 서비스 네트워크
    VM Network#2|900|가상머신 개발 네트워크


2. 가상 스위치 설계 

    네트워크 구분|VLAN ID|포트그룹 이름|vSwitch|비고
    ---|---|---|---|---
    관리|100|PG-100-MGMT<td rowspan="3">vSwitch-MGMT</td>|ESXi 하이퍼바이저 관리용
    vMotion|200|PG-200-vMotion|vMotion 트래픽 전용
    iSCSI 스토리지|300|PG-300-Storage|공유 스토리지 연결
    VM Network#1|800|PG-800-PROD<td rowspan="2">vSwitch-VM</td>|가상머신 서비스 네트워크
    VM Network#2|900|PG-900-DEV|가상머신 개발 네트워크


3. 업-링크 설계

    네트워크 구분|VLAN ID|포트그룹 이름|vSwitch|MTU|Uplink|물리포트맵|로드밸런싱|Failover|비고
    ---|---|---|---|---|---|---|---|---|---
    관리|100|PG-100-MGMT<td rowspan="3">vSwitch-MGMT</br>(표준스위치)</td><td rowspan="3">1500</td><td rowspan="3">Uplink 1: Vmnic0:NIC1–P1</br>Uplink 2: Vmnic2:NIC2-P1</td><td rowspan="3">NIC1–P1 TOR#1:eth1/1</br>NIC2–P1  TOR#2:eth1/1</td><td rowspan="3">Active-Standby</br>원래 포트 기반 라우팅</td><td rowspan="3">네트워크 장애 감지:</br>- Link Status Only</br>- Notify Switch : Yes</br>- Failback : Yes</td>|ESXi 하이퍼바이저 관리용
    vMotion|200|PG-200-vMotion|vMotion 트래픽 전용
    iSCSI 스토리지|300|PG-300-Storage|공유 스토리지 연결
    VM Network#1|800|PG-800-PROD<td rowspan="2">vSwitch-VM</br>(분산스위치)</td><td rowspan="2">1500</td><td rowspan="2">Uplink 1: Vmnic1:NIC1–P2</br>Uplink 2: Vmnic3:NIC2-P2</td><td rowspan="2">NIC1–P1 TOR#1:eth1/2</br>NIC2–P1  TOR#2:eth1/2</td><td rowspan="2">Active-Standby</br>사용량 기반 라우팅</td><td rowspan="2">네트워크 장애 감지:</br>- Link Status Only</br>- Notify Switch : Yes</br>- Failback : Yes</td>|가상머신 서비스 네트워크
    VM Network#2|900|PG-900-DEV|가상머신 개발 네트워크
    
    Failover - Notify Switch 옵션 : Uplink장애 발생후 Failover시 대상 VM의 주소정보를 이용해 GARP패킷을 발생시켜 스위치의 ARP테이블을 빠르게 업데이트

~~~php
use Junges\Kafka\Facades\Kafka;

Kafka::publishOn('topic')
~~~

<script>

function escapeRegExp(string) {
    return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); // $& means the whole matched string
}

/**
 * Removes excluded text from a Node.
 *
 * @param {Node} target Node to filter.
 * @param {string} exclude CSS selector of nodes to exclude.
 * @returns {DOMString} Text from `target` with text removed.
 */
export function filterText(target, exclude) {
    const clone = target.cloneNode(true);  // clone as to not modify the live DOM
    if (exclude) {
        // remove excluded nodes
        clone.querySelectorAll(exclude).forEach(node => node.remove());
    }
    return clone.innerText;
}

// Callback when a copy button is clicked. Will be passed the node that was clicked
// should then grab the text and replace pieces of text that shouldn't be used in output
export function formatCopyText(textContent, copybuttonPromptText, isRegexp = false, onlyCopyPromptLines = true, removePrompts = true, copyEmptyLines = true, lineContinuationChar = "", hereDocDelim = "") {
    var regexp;
    var match;

    // Do we check for line continuation characters and "HERE-documents"?
    var useLineCont = !!lineContinuationChar
    var useHereDoc = !!hereDocDelim

    // create regexp to capture prompt and remaining line
    if (isRegexp) {
        regexp = new RegExp('^(' + copybuttonPromptText + ')(.*)')
    } else {
        regexp = new RegExp('^(' + escapeRegExp(copybuttonPromptText) + ')(.*)')
    }

    const outputLines = [];
    var promptFound = false;
    var gotLineCont = false;
    var gotHereDoc = false;
    const lineGotPrompt = [];
    for (const line of textContent.split('\n')) {
        match = line.match(regexp)
        if (match || gotLineCont || gotHereDoc) {
            promptFound = regexp.test(line)
            lineGotPrompt.push(promptFound)
            if (removePrompts && promptFound) {
                outputLines.push(match[2])
            } else {
                outputLines.push(line)
            }
            gotLineCont = line.endsWith(lineContinuationChar) & useLineCont
            if (line.includes(hereDocDelim) & useHereDoc)
                gotHereDoc = !gotHereDoc
        } else if (!onlyCopyPromptLines) {
            outputLines.push(line)
        } else if (copyEmptyLines && line.trim() === '') {
            outputLines.push(line)
        }
    }

    // If no lines with the prompt were found then just use original lines
    if (lineGotPrompt.some(v => v === true)) {
        textContent = outputLines.join('\n');
    }

    // Remove a trailing newline to avoid auto-running when pasting
    if (textContent.endsWith("\n")) {
        textContent = textContent.slice(0, -1)
    }
    return textContent
}
</script>