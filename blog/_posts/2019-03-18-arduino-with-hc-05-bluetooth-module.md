---
layout: post
title: 'Arduino with HC-05 Bluetooth module' 
author: haeyeon.hwang
tags: [iot, hackathon]
description: >
  HC‐05 module is an easy to use Bluetooth SPP (Serial Port Protocol) module,designed for transparent wireless serial connection setup.The HC-05 Bluetooth Module can be used in a Master or Slave configuration, making it a great solution for wireless communication.This serial port bluetooth module is fully qualified Bluetooth V2.0+EDR (Enhanced Data Rate) 3Mbps Modulation with complete 2.4GHz radio transceiver and baseband. It uses CSR Bluecore 04‐External single chip Rluetooth system with CMOS technology and with AFH (Adaptive Frequency Hopping Feature).
image: /assets/img/blog/bluetooth-hc-05.png
hide_image: true
---

![pinout](/assets/img/blog/arduino-uno-pinout.png)

https://www.youtube.com/watch?v=QUQta4f_87E
https://www.instructables.com/id/Upgrade-Your-3-Bluetooth-Module-to-Have-HID-Firmwa/
https://eggelectricunicycle.bitbucket.io/Flash_and_Debug_STM32--Flash_firmware_using_Bluetooth--ZS-040_Bluetooth_module.html
https://m.blog.naver.com/PostView.nhn?blogId=gauya&logNo=221223134228&proxyReferer=https%3A%2F%2Fwww.google.com%2F
http://blog.naver.com/PostView.nhn?blogId=rlrkcka&logNo=220602311579&parentCategoryNo=&categoryNo=18&viewDate=&isShowPopularPosts=true&from=search
http://blog.naver.com/PostView.nhn?blogId=zeta0807&logNo=221179614788


```c
SoftwareSerial BTserial(8, 9); // RX | TX
 
const long baudRate = 38400; 
char c=' ';
boolean NL = true;
 
void setup() 
{
    Serial.begin(9600);
    Serial.print("Sketch:   ");   Serial.println(__FILE__);
    Serial.print("Uploaded: ");   Serial.println(__DATE__);
    Serial.println(" ");
 
    BTserial.begin(baudRate);  
    Serial.print("BTserial started at "); Serial.println(baudRate);
    Serial.println(" ");
}
 
void loop()
{ 
    // Read from the Bluetooth module and send to the Arduino Serial Monitor
    if (BTserial.available())
    {
        c = BTserial.read();
        Serial.write(c);
    }
 
    // Read from the Serial Monitor and send to the Bluetooth module
    if (Serial.available())
    {
        c = Serial.read();
        BTserial.write(c);   
 
        // Echo the user input to the main window. The ">" character indicates the user entered text.
        if (NL) { Serial.print(">");  NL = false; }
        Serial.write(c);
        if (c==10) { NL = true; }
    }
}
```