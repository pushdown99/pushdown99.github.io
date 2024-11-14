---
layout: post
title: 'vagrant' 
author: haeyeon.hwang
tags: [container runtime, OCI]
description: >
  컨테이너 런타임 관련 내용 
image: /assets/img/blog/vSphere.png
hide_image: true
---

## 컨테이너 런타임

https://velog.io/@juunini/Docker-Podman-Containerd-CRI-O-%EC%9D%B4%EA%B2%8C-%EB%8B%A4-%EB%AD%90%EC%8B%A0%EA%B0%80

### Docker vs. Podman

특징|Docker|Podman
---|---|---
정의|컨테이너화 애플리케이션을 생성 및 관리하는 도구|도커 CLI와 호환되는 컨테이너 관리 도구
아키텍처|클라이언트-서버 모델, 중앙 집중식 데몬|데몬 없는 아키텍처, 각 컨테이너가 독립적으로 실행
보안|데몬이 root 권한을 필요로 함|기본적으로 root 없이 실행, 보안상 이점 제공
사용 용이성|광범위한 사용자 기반, 널리 사용되는 명령어와 인터페이스|Docker 명령어와 호환, 사용자 전환 용이
커뮤니티 및 지원|광범위한 커뮤니티와 상업적 지원|Red Hat 및 오픈소스 커뮤니티에 의해 지원
이미지 호환성|자체 이미지 형식 및 레지스트리 사용|Docker 이미지 형식과 호환
오케스트레이션|Docker Swarm 및 Kubernetes와 통합|주로 Kubernetes와 통합
확장성 및 성능|대규모 환경 및 클러스터 관리에 적합|경량화 및 빠른 시작 시간, 개별 컨테이너 관리에 최적화

### containerd vs. CRI-O

특징|containerd|CRI-O
---|---|---
정의|Docker의 핵심 컴포넌트로 분리된, 고성능 컨테이너 런타임|쿠버네티스의 경량 컨테이너 런타임
용도|다양한 환경에서 컨테이너 실행 및 관리|쿠버네티스에 최적화된 컨테이너 관리
호환성|Docker 이미지 및 레지스트리와 호환|OCI(Open Container Initiative) 표준을 준수
커뮤니티 및 지원|Docker 및 CNCF(클라우드 네이티브 컴퓨팅 재단) 지원|Red Hat 및 쿠버네티스 커뮤니티 지원
아키텍처|모듈식 구조, 다양한 플러그인 지원|Kubernetes CRI(컨테이너 런타임 인터페이스)를 구현
성능 및 효율성|고성능, 안정적인 컨테이너 관리|경량화 및 빠른 시작 시간에 초점
보안|강력한 보안 기능|쿠버네티스 통합 보안 기능
