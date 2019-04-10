---
layout: post
title: '(2019) 서울 하드웨어 해커톤' 
author: haeyeon.hwang
tags: [esp8266, mbed, mqtt, sensor]
image: /assets/img/blog/hackathon.png
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **2019 서울 하드웨어 해커톤 (SEOUL HARDWARE HACKATHON)**

구분|내용  
---|---
주제|사회적 약자 문제를 해결하는 ICT 기술 [참고](https://www.seoulhackathon.org/441)
공동주관|한국산업단지공단, 서울산업진흥원, arm, 마이크로소프트
개발조건|①arm MBED, ②arm MBED => arm Pelion => 클라우드 ③arm MBED => Microsoft AZURE IoT 중 하나. 
모집기간|‘19.02.15 ~ 19.3.6 23:59 까지
참가규모|30팀 내외(120명 내외, 팀 당 4명 내외 구성)  
참가요건|H/W개발자, S/W개발자 각 1명 이상(필수)으로 구성된 4인 내외의 팀 (되도록이면 4인 준수요망, 4인 초과시 사전연락요망)
지원내용|팀당 개발지원금 30민원,개발 워크숍,기술 및 가공지원

![DISCO](/assets/img/blog/DISCO_L475VG_IOT01A.jpg)
![ODIN](/assets/img/blog/EVK-ODIN-W2-5_09102017_2.png)

## **해커톤 주제**


[참고사이트](http://docs.micropython.org/en/v1.9.4/esp8266/esp8266/tutorial/intro.html)

1. 펌웨어 다운로드 (Getting the firmware)

[MicroPython download page](http://micropython.org/download#esp8266)

`wind+x` 키를 눌러서 포트(COM & LPT)의 COM포트번호를 확인

3. ESP8266 보드에 설치하기
   
~~~bash
\> pip install esptool
\> esptool.py --port COMxx erase_flash
\> esptool.py --port COMxx write_flash 0 xxx.bin
esptool.py v2.6
Serial port COM13
Connecting....
...

Leaving...
Hard resetting via RTS pin...
~~~

~~~python
import esp
esp.check_fw()
~~~

~~~python
from machine import Pin
from time import sleep

led = Pin(2, Pin.OUT)

while True:
  led.value(not led.value())
  sleep(0.5)
~~~
