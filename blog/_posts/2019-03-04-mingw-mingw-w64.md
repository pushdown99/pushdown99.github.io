---
layout: post
title: 'Windows 환경에서 gcc 컴파일하는 방법' 
author: haeyeon.hwang
date: 2018-12-24 10:00
tags: [mbed-cli]
image: /files/covers/gcc compile error.png
---

MinGW(과거 이름: mingw32)는 마이크로소프트 윈도로 포팅한 GNU 소프트웨어 도구 모음이다.

MinGW는 윈도 API를 구현할 수 있는 헤더 파일들을 가지고 있으며 이로써 개발자들이 "자유롭게 쓸 수 있는" 컴파일러인 GCC를 사용할 수 있다. 시그윈 포팅을 사용할 경우 컴파일한 프로그램 결과물이 유닉스 계통의 기능을 가상으로 구현하는 런타임에 의존하는 반면, MinGW의 경우 이러한 기능에 의존하지 않고 마이크로소프트 윈도 기반 프로그램들을 만들 수 있다.

이 MinGW 프로젝트는 두 개의 기본 꾸러미를 관리하고 배포한다. 첫째로는 포팅된 GCC 컴파일러들은 윈도 명령 줄에서, 아니면 IDE에 통합된 채로 쓸 수 있다. 아니면 둘째로는 MSYS(minimal system의 약자)를 쓸 수도 있는데, 이것은 가벼운 유닉스 계통의 셸 환경을 제공한다. 이러한 환경은 rxvt와 autoconf 스크립트들을 실행하는 데에 충분한 POSIX 도구들이 집약되어 있다.

두 개의 꾸러미들은 원래 시그윈 일부의 forks였으며 forks는 네이티브 윈도 기능 덕에 더 포괄적인 유닉스 계통의 지원을 제공한다. 두 개의 꾸러미들은 자유 소프트웨어이다. Win32 헤더 파일들은 공용 도메인에 공개된다. 반면 GNU에서 포팅되는 프로그램들은 GNU 일반 공중 사용 허가서 하에서 사용할 수 있다. 완전한 MSYS 꾸러미와 개별 MinGW GNU 유틸리티들의 바이너리 파일들은 MinGW 사이트에서 내려 받을 수 있다. `위키`


windows mingw란 c++ - Cygwin과 MinGW의 차이점은 무엇입니까?

Cygwin은 Windows에서 완전한 UNIX / POSIX[^1] 환경을 만들기위한 시도입니다.  
이를 위해 다양한 DLL을 사용합니다.   
이 DLL은 GPLv3 +에 의해 보호되지만 GPLv3 +에서 파생 된 작업을 강제로 제외 하지는 않습니다.  
MinGW는 C / C ++ 컴파일러 모음으로, DLL과 관련없이 Windows 실행 파일을 만들 수 있습니다.  
일반적인 Microsoft Windows 설치의 일부인 일반 MSVC 런타임 만 있으면됩니다.

또한 MSYS 와 함께 컴파일 된 MSYS 라는 작은 UNIX / POSIX 환경을 사용할 수 있습니다.  
Cygwin의 모든 기능을 지원하지는 않지만 MinGW를 사용하고자하는 프로그래머에게 이상적입니다.


[http://klutzy.nanabi.org/blog/2015/03/05/mingw/](http://klutzy.nanabi.org/blog/2015/03/05/mingw/)

[^1]: POSIX(포직스, /ˈpɒzɪks/)는 이식 가능 운영 체제 인터페이스(移植可能運營體制 interface, portable operating system interface)[1]의 약자로, 서로 다른 UNIX OS의 공통 API를 정리하여 이식성이 높은 유닉스 응용 프로그램을 개발하기 위한 목적으로 IEEE가 책정한 애플리케이션 인터페이스 규격이다. POSIX의 마지막 글자 X는 유닉스 호환 운영체제에 보통 X가 붙는 것에서 유래한다. 규격의 내용은 커널로의 C 언어 인터페이스인 시스템 콜 뿐 아니라, 프로세스 환경, 파일과 디렉터리, 시스템 데이터베이스(암호 파일 등), tar 압축 포맷 등 다양한 분야를 아우른다. 유닉스 계열 외에 마이크로소프트 윈도 NT는 POSIX 1.0에 준하는 POSIX 서브 시스템을 탑재하고 있으며, POSIX 응용 프로그램을 서브 시스템에서 실행할 수 있다. 이는 주로 미국 정부기관의 컴퓨터 시스템 도입조건(FIPS)에서 POSIX 준거할 것을 요구하기 때문이다. 윈도 2000까지 POSIX 서브시스템을 탑재하고 있었지만 윈도 XP에서 폐지되었다. 이후 윈도 2003 R2 부터 POSIX 2.0에 준하는 Subsystem for UNIX-based Applications(SUA)를 통해 POSIX를 지원하고 있다.[2]