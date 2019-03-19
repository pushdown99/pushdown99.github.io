---
layout: post
title: 'Cushion sensor' 
author: haeyeon.hwang
tags: [iot, hackathon]
description: >
  A heat map (or heatmap) is a graphical representation of data where the individual values contained in a matrix are represented as colors. "Heat map" is a newer term but shading matrices have existed for over a century. `wiki`
image: /assets/img/blog/mdxs-16-5610.jpg
hide_image: true
---
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **How to handle cushion sensor**
1. order from [here](http://mechasolution.com/shop/goods/goods_view.php?goodsno=577041&category=129028)  
   * arduino 31channel pressure cushion sensor + shield set
   * parts
  
    part|model|unit|description
    ---|---|---|---
    sensor|mdxs-16-5610|1|
    mcu|arduino pro micro|1|
    shield board||1|
    guide panel||1|
    form tape||1|

   * form factor
  
    part/model|form factor(mm)
    ---|---
    mdxs-16-5610|388 x 380
    shield board|157 x 28 


    ![mdx](/assets/img/blog/mdxs-16-5610.jpg){: width="50%"}

2. read multi-channel sensor value with arduino  
  
    ![channel](/assets/img/blog/mdxs-16-5610-channel.png){: width="70%"}

    ~~~c
    int En0 =7; //Lowenabled
    int En1 =6; //Lowenabled
    int S0  =5;
    int S1  =4;
    int S2  =3;
    int S3  =2;

    int SIG_pin=A3;

    int readMux(int channel){
        int controlPin[]={S0,S1,S2,S3,En0,En1};
        int muxChannel[32][6]={
            {0,0,0,0,0,1},//channel0
            {0,0,0,1,0,1},//channel1
            {0,0,1,0,0,1},//channel2
            {0,0,1,1,0,1},//channel3
            {0,1,0,0,0,1},//channel4
            {0,1,0,1,0,1},//channel5
            {0,1,1,0,0,1},//channel6
            {0,1,1,1,0,1},//channel7
            {1,0,0,0,0,1},//channel8
            {1,0,0,1,0,1},//channel9
            {1,0,1,0,0,1},//channel10
            {1,0,1,1,0,1},//channel11
            {1,1,0,0,0,1},//channel12
            {1,1,0,1,0,1},//channel13
            {1,1,1,0,0,1},//channel14
            {1,1,1,1,0,1},//channel15
            {0,0,0,0,1,0},//channel16
            {0,0,0,1,1,0},//channel17
            {0,0,1,0,1,0},//channel18
            {0,0,1,1,1,0},//channel19
            {0,1,0,0,1,0},//channel20
            {0,1,0,1,1,0},//channel21
            {0,1,1,0,1,0},//channel22
            {0,1,1,1,1,0},//channel23
            {1,0,0,0,1,0},//channel24
            {1,0,0,1,1,0},//channel25
            {1,0,1,0,1,0},//channel26
            {1,0,1,1,1,0},//channel27
            {1,1,0,0,1,0},//channel28
            {1,1,0,1,1,0},//channel29
            {1,1,1,0,1,0},//channel30
            {1,1,1,1,1,0}//channel31
        };

        // loop through the 6 sig
        for(int i=0;i<6;i++){
            digitalWrite(controlPin[i],muxChannel[channel][i]);
        }
        // read the value at the SIG pin
        int val=analogRead(SIG_pin);
        // return the value
        return val;
    }

    void setup(){
        Serial.begin(115200);
        pinMode(En0, OUTPUT);
        pinMode(En1, OUTPUT);
        pinMode(S0,  OUTPUT);
        pinMode(S1,  OUTPUT);
        pinMode(S2,  OUTPUT);
        pinMode(S3,  OUTPUT);
    }

    void loop(){
        for(int i=0;i<32;i++){
            Serial.print(readMux(i));
            Serial.print("/");
            delay(1);
            Serial.print("");
        }
        Serial.println("");
        delay(500);
    }
    ~~~

3. http://www.mdex-shop.com/web/upload/NNEditor/20180625/32CHEC89B4EB939C2BEBB0A9EC849DEC84BCEC849C_180612.png
