---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# Arm Mbed

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## [Online Mbed Compiler](https://os.mbed.com/)
### 환경설정 
1. [Online Mbed Compiler](https://os.mbed.com/)로 이동 후 [계정생성](https://os.mbed.com/account/signup/)
2. PC와 Mbed 보드를 USB로 연결한 후 USB device 폴더 내 `MBED.HTM`을 더블클릭 (온라인 컴파일러에 플랫폼이 추가됨)
3. 또는 [Mbed board](https://os.mbed.com/platforms)에서 Mbed 보드를 찾아서 컴파일러에 추가  
  ![desktop IDE](https://s3-us-west-2.amazonaws.com/mbed-os-docs-images/add_to_compiler.png)

### 개발  
1. Import
  [Blinky example repository](https://os.mbed.com/teams/mbed-os-examples/code/mbed-os-example-blinky/)로 이동하여, **Import into Compiler**를 클릭  

  ![mbed OS Blinky](https://s3-us-west-2.amazonaws.com/mbed-os-docs-images/import_into_compiler.png) 


2. **Compile**을 클릭하고, 컴파일된 파일을 브라우저로부터 다운로드  
   
  ![mbed OS compile](https://s3-us-west-2.amazonaws.com/mbed-os-docs-images/online_compile_button.png)  


3. 프로그램
   * 다운받은 파일을 Mbed board의 USB device 폴더에 복사
   * Mbed 보드에 파일이 `flashed` 되면, 보드의 `reset` 버튼을 눌러 초기화 

---

## Mbed CLI (오프라인 Mbed Compiler)
### [mbed-cli-windows-installer](https://github.com/ARMmbed/mbed-cli-windows-installer/releases/latest) 다운로드 후 설치  
   `https://github.com/ARMmbed/mbed-cli-windows-installer/releases/latest`

  * `mbed-cli-windows-installer` components  
   
  순번|컴포넌트|버전|비고
  ---|---|---|---
  1|Python|[2.7.13](https://www.python.org/downloads/release/python-2713/)|Mbed CLI is a Python script, so you need Python to use it. <BR>It is not compatible with Python 3.
  2|Mbed CLI|[1.2.2](https://github.com/ARMmbed/mbed-cli)|
  3|Git|[2.12.2](https://git-scm.com/)|added to system's PATH.
  4|Mercurial|[4.1.1](https://www.mercurial-scm.org/)|added to system's PATH.
  5|[GNU Arm Embedded Toolchain](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads)||
  6|[Mbed Windows serial port driver](https://os.mbed.com/docs/v5.9/tutorials/windows-serial-driver.html)||

### 정상설치 여부 확인
   
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
