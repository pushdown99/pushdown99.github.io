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

## (2019) 서울 하드웨어 해커톤


구분|내용
---|---
현장해커톤|'19/03/30 ~ 31 (1박2일)
주제|사회적 약자 문제를 해결하는 ICT 기술
개발조건|Mbed ➝ Pelion/Azure
제공보드| mbed board


## 과제개요

팀명|플러스디(Plus-D)
과제|욕창방지방석(매트)
개요|욕창(蓐瘡)이란? 신체부위 지속적압박➝피부괴사➝세균침투/패혈증, 욕창방지매트=거동이불편한 중환자 필수의료기
문제점|기존매트는 공기를 주기적 주입/분출하는 방식➝기기적오류 미감지 (예: 에어호스이탈 또는 꼬임, 공기주머니 미동작 등), 환자상태를 모름, 병원에서의 욕창유별률(4.7%~32.1%; 중환자실 30~40%)
해결|환자의 압력을 측정하고 이를 토대로 적절히 분산하고, 일정시간 압력이 집중되는 경우 이를 보호자에게 고지

![logo](/assets/img/blog/blue-eye-logo.png)

## 프로젝트 개발과정 

1. 물품구매내역

부품|모델|단가|개수|가격
:---|:---|---:|:---:|---:
압력센서|[mdxs-16-5610](http://mechasolution.com/shop/goods/goods_view.php?goodsno=577041&category=)|69,300|2|69,300
수집노드|[esp-wroom-32](http://mechasolution.com/shop/goods/goods_view.php?&goodsno=577245)|11,000|1|11,000
 |[esp12e](http://mechasolution.com/shop/goods/goods_view.php?goodsno=539744&category=)|5,720|1|5,720
중계기|[mbed board](https://os.mbed.com/platforms/ST-Discovery-L475E-IOT01A/)|||


## 전체시스템구성

![](/assets/img/blog/blue-eye-1.png)

### 압력센서 + ESP32(ESP8266)
  
[`github`](https://github.com/pushdown99/hackathon)

~~~bash
$ wget https://github.com/pushdown99/hackathon/blob/master/arduino/arduino.ino
$ wget https://github.com/pushdown99/hackathon/blob/master/esp8266/esp8266.ino
~~~

구분|내용
---|---
Sensors(selection)|(4 x Digtial Ouput) + (2 x En) Pin 
Value|지정된 Analog Input 

~~~c
pinMode(En0, OUTPUT); // 25
pinMode(En1, OUTPUT); // 26
pinMode(S0,  OUTPUT); // 27
pinMode(S1,  OUTPUT); // 14
pinMode(S2,  OUTPUT); // 12
pinMode(S3,  OUTPUT); // 13

char* getData(char *buf, int len) {
  int controlPin[] = {S0,S1,S2,S3,En0,En1};
  int muxChannel[31][6]={
    {0,0,0,0,0,1}, //channel 0
    {0,0,0,1,0,1}, //channel 1
    {0,0,1,0,0,1}, //channel 2
    {0,0,1,1,0,1}, //channel 3
    {0,1,0,0,0,1}, //channel 4
    ...
  };
  for(int channel=0; channel< 31; channel++) {
    for(int i=0; i<6; i++) {
      digitalWrite(controlPin[i], muxChannel[channel][i]);
    }
    val = (int)analogRead(SP); // 34
  }
}
~~~

### ESP8266

* 아두이노IDE에 보드매니저(Board Manager) 등록

  ![](/assets/img/blog/sketch.png)

  아두이노IDE > File > Preferences > Additional Board Manager URLs

  ~~~bash
  http://arduino.esp8266.com/stable/package_esp8266com_index.json
  https://dl.espressif.com/dl/package_esp32_index.json
  ~~~

* 외부 라이브러리 추가  

  - 다운로드 zip 파일 [softAP Library](https://github.com/prampec/IotWebConf)  
  - 라이브러리 추가  

    ![](/assets/img/blog/sketch-zip.png)

    ~~~c
    #include <IotWebConf.h>
    #include <ArduinoJson.h>
    #include <PubSubClient.h>
    ~~~

* ESP8266 라이브러리 추가
  - 라이브러리 검색 추가

    아두이노IDE > Sketch > include Library > Manage libraries

    ![](/assets/img/blog/sketch-lib.png)

    ~~~c
    #include <ArduinoJson.h>
    #include <PubSubClient.h>
    ~~~

### Mbed

* [ST-Discovery-L475E-IOT01A](https://os.mbed.com/platforms/ST-Discovery-L475E-IOT01A/) 보드  
  
  ![](/assets/img/blog/DISCO_L475VG_IOT01A.jpg)

* arm Mbed 개발 

  - [Mbed](https://os.mbed.com/)

    ![](/assets/img/blog/os-mbed-com.png)

  - [Online Compiler](https://ide.mbed.com/compiler/)
  
    ![](/assets/img/blog/os_mbed_compiler.png)

  - [Mbed Portal](https://portal.mbedcloud.com/)

    ![](/assets/img/blog/portal_mbed.png)

  - [pelion-example-disco-iot01](https://os.mbed.com/teams/ST/code/pelion-example-disco-iot01/): WiFi + Pelion
  - How to Install
    - pelion example code import and compile
  
    ~~~bash
    $ mbed import http://os.mbed.com/teams/ST/code/pelion-example-disco-iot01/
    $ cd pelion-example-disco-iot01
    $ mbed config -G CLOUD_SDK_API_KEY <PELION_DM_API_KEY>
    $ mbed dm init -d "https://api.us-east-1.mbedcloud.com" --model-name "DISCO_L475VG_IOT01A" -q --force
    ~~~

    - add mbed-http library
  
    ~~~bash
    $ mbed add http://os.mbed.com/teams/sandbox/code/mbed-http/
    ~~~
  
  - 소스코드 2개를 내려받고, WiFi connectivity 수정 후 Compile
  
  ~~~bash
  $ wget https://github.com/pushdown99/hackathon/blob/master/mbed/main.cpp -O main.cpp
  $ wget https://github.com/pushdown99/hackathon/blob/master/mbed/mbed_app.json -O mbed_app.json
  $ vi mbed_app.cpp
      "target_overrides": {
        "nsapi.default-wifi-ssid"    : "\"{{SSID}}\"",
        "nsapi.default-wifi-password": "\"{{PASSWORD}}\""
      }
  $ mbed compile -t GCC_ARM -m DISCO_L475VG_IOT01A
  ~~~

  - Copy firmware `*.bin` file to board storage.

### Heroku

* Installation
  [Heroku-CLI](https://devcenter.heroku.com/articles/heroku-cli)

  ~~~bash
  $ curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
  $ heroku --version
  heroku/7.0.0 (darwin-x64) node-v8.0.0
  ~~~

* Example Programming
  
  ~~~bash
  $ heroku login
  heroku: Enter your login credentials
  Email: me@example.com
  Password:
  Two-factor code:
  Logged in as me@heroku.com

  $ git clone https://github.com/pushdown99/mbed-iot.git
  $ cd mbed-iot
  $ git remote -v
  $ git remote rm origin
  $ git init .
  $ heroku apps:create {{heroku-app-namne}}
  $ heroku buildpacks:set heroku/php
  $ heroku buildpacks:add heroku/python
  $ heroku addons:create heroku-postgresql:hobby-dev
  $ git push heroku master
  ~~~

* SQL schema and table setting
  - `pg/table.sql` SQL 실행 
  
  ~~~bash
  $ heroku pg:psql
  --> Connecting to postgresql
  psql (9.5.14, server 11.2 (Ubuntu 11.2-1.pgdg16.04+1))
  WARNING: psql major version 9.5, server major version 11.
           Some psql features might not work.
  SSL connection (protocol: TLSv1.2, cipher: ECDHE-RSA-AES256-GCM-SHA384, bits: 256, compression: off)
  Type "help" for help.

  DATABASE=> CREATE...

  $ heroku ps:scale web=1
  $ heroku open
  ~~~

## 화면/결과물

![](/assets/img/blog/hackathon1.png)
![](/assets/img/blog/hackathon2.png)

Output|Download
---|---
팀/제품설명|[pptx](/assets/doc/cushion.pptx)
제품설명|[pptx](/assets/doc/pd-cushion.pptx)
동영상|[mp4](/assets/doc/pd-cushion.mp4)

