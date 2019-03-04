---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# Arm Mbed

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## 온라인 Mbed Compiler
## Mbed CLI 설치하기
* [mbed-cli-windows-installer](https://github.com/ARMmbed/mbed-cli-windows-installer/releases/latest) 설치파일을 다운로드 후 설치  
   `https://github.com/ARMmbed/mbed-cli-windows-installer/releases/latest`

  * `mbed-cli-windows-installer` 에 포함된 컴포넌트  
   
  순번|컴포넌트|버전|비고
  ---|---|---|---
  1|Python|[2.7.13](https://www.python.org/downloads/release/python-2713/)|Mbed CLI is a Python script, so you need Python to use it. <BR>It is not compatible with Python 3.
  2|Mbed CLI|[1.2.2](https://github.com/ARMmbed/mbed-cli)|
  3|Git|[2.12.2](https://git-scm.com/)|added to system's PATH.
  4|Mercurial|[4.1.1](https://www.mercurial-scm.org/)|added to system's PATH.
  5|[GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads)||
  6|[Mbed Windows serial port driver](https://os.mbed.com/docs/v5.9/tutorials/windows-serial-driver.html)||

* `mbed-cli-windows-installer` 정상 설치여부 확인
   
```shell
C:\> arm-none-eabi-gcc --version
C:\> python --version
C:\> pip --version
C:\> git --version
C:\> hg --version
```
`win`+`x`

*single asterisks*  
_single underscores_  
**double asterisks**  
__double underscores__  
++underline++  
~~cancelline~~  
