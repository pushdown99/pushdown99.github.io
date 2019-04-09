---
layout: post
title: '서울 하드웨어 해커톤' 
author: haeyeon.hwang
tags: [esp8266, mbed, mqtt, sensor]
image: /assets/img/blog/hackathon.png.png
hide_image: true
---

{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **서울 하드웨어 해커톤 (seoul hardware hackathon 2019)**
1. 아래 사이트 참고

[참고사이트](http://docs.micropython.org/en/v1.9.4/esp8266/esp8266/tutorial/intro.html)

2. 펌웨어 다운로드 (Getting the firmware)

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
