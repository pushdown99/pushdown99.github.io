---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# Node MCU
NodeMCU is an open source IoT platform.[^1][^2] It includes firmware which runs on the ESP8266 Wi-Fi SoC from Espressif Systems, and hardware which is based on the ESP-12 module.[^3][^4] The term "NodeMCU" by default refers to the firmware rather than the development kits. The firmware uses the Lua scripting language. It is based on the eLua project, and built on the Espressif Non-OS SDK for ESP8266. It uses many open source projects, such as lua-cjson[^5] and SPIFFS.[^6]  [`wiki`](https://en.wikipedia.org/wiki/NodeMCU)  


{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}
![Screenshot](/assets/img/docs/nodemcu.jpg)

## Pinout
![Screenshot](/assets/img/docs/NodeMCUv3.0-pinout.jpg)

* [CP210x USB to UART Bridge VCP Drivers](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers)

https://developer.ibm.com/kr/cloud/internet-of-things/2017/07/30/esp8266-iot-arduino-ide-nodemcu-basic/

아두이노 (Arduino) IDE 에 NodeMCU 보드 설정
1. https://www.arduino.cc/en/Main/Software 에서 OS 에 맞는 아두이노 IDE 를 다운받아 설치합니다.
2. Preferences 에서 Additional Board Manager URLs 에 http://arduino.esp8266.com/stable/package_esp8266com_index.json 를 입력합니다.
3. Tools > Board > Board Manager... 에서 eps8266 보드를 설치합니다.
4. Tools > Board 에서 NodeMCU 1.0 보드를 선택합니다.
5. Port 에서 NodeMCU 보드에 연결된 시리얼 포트를 선택합니다.

https://electrosome.com/esp8266-arduino-programming-led-blink/
https://www.tinkercad.com/

Ain = ADC
Aout = DAC(x), PWM 10bit
Pulse width modulation
아날로그 5분대기? 핀모드가 필요없음

디지털입력
- 메모리
- 상태확인 (H->L, L->H); 평소상대를 올려놓으면 pull-up, 평소상태를 내려놓으면 pull-down R=10k 정도사용함.
  
https://tttapa.github.io/ESP8266/Chap04%20-%20Microcontroller.html

pull-up - Low에서 동작

## Exmaples

### Bink LED
```c
void setup() {
  pinMode(D0, OUTPUT);
}

// the loop function runs over and over again forever
void loop() {
  digitalWrite(D0, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(1000);
  digitalWrite(D0, LOW);    // turn the LED off by making the voltage LOW
  delay(1000);
}
```

### Bink LED w/ switch
```c
void setup() {
  pinMode(D0, OUTPUT);
  pinMode(D1, INPUT);
  Serial.begin(9600);
}

// the loop function runs over and over again forever
void loop() {
  int Sw = digitalRead(D1);
  Serial.println(Sw);
  
  if(Sw > 0) { digitalWrite(D0, HIGH); }
   else      { digitalWrite(D0, LOW);  }
}
```
### Bink LED w/ variable register + PWM
```c
void setup() {
  Serial.begin(9600);
}

// the loop function runs over and over again forever
void loop() {
  int Adc = analogRead(A0);
  int level = map(Adc, 0, 1023, 0, 10);
  Serial.println(level);
  analogWrite(D0,Adc);
}
```
### Lua Programming
https://github.com/nodemcu/nodemcu-firmware

Connect to the wireless network
```lua
print(wifi.sta.getip())
--nil
wifi.setmode(wifi.STATION)
wifi.sta.config("SSID","password")
print(wifi.sta.getip())
--192.168.18.110
```

Arduino like IO access
```lua
pin = 1
gpio.mode(pin,gpio.OUTPUT)
gpio.write(pin,gpio.HIGH)
gpio.mode(pin,gpio.INPUT)
print(gpio.read(pin))
`

HTTP Client
```lua
-- A simple http client
conn=net.createConnection(net.TCP, false) 
conn:on("receive", function(conn, pl) print(pl) end)
conn:connect(80,"121.41.33.127")
conn:send("GET / HTTP/1.1\r\nHost: www.nodemcu.com\r\n"
    .."Connection: keep-alive\r\nAccept: */*\r\n\r\n")
```

HTTP Server
```lua
-- a simple http server
srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive",function(conn,payload) 
    print(payload) 
    conn:send("<h1> Hello, NodeMcu.</h1>")
    end) 
end)
`

PWM
```lua
function led(r,g,b) 
    pwm.setduty(1,r) 
    pwm.setduty(2,g) 
    pwm.setduty(3,b) 
end
pwm.setup(1,500,512) 
pwm.setup(2,500,512) 
pwm.setup(3,500,512)
pwm.start(1) 
pwm.start(2) 
pwm.start(3)
led(512,0,0) -- red
led(0,0,512) -- blue
```

Blinking Led
```lua
lighton=0
tmr.alarm(0,1000,1,function()
if lighton==0 then 
    lighton=1 
    led(512,512,512) 
    -- 512/1024, 50% duty cycle
else 
    lighton=0 
    led(0,0,0) 
end 
end)
```

Bootstrap
```lua
--init.lua will be excuted
file.open("init.lua","w")
file.writeline([[print("Hello World!")]])
file.close()
node.restart()  -- this will restart the module.
```

Use timer to repeat
```c
tmr.alarm(1,5000,1,function() print("alarm 1") end)
tmr.alarm(0,1000,1,function() print("alarm 0") end)
tmr.alarm(2,2000,1,function() print("alarm 2") end)
-- after sometime
tmr.stop(0)
```

A pure lua telnet server
```lua
-- a simple telnet server
s=net.createServer(net.TCP,180) 
s:listen(2323,function(c) 
    function s_output(str) 
      if(c~=nil) 
        then c:send(str) 
      end 
    end 
    node.output(s_output, 0)   
    -- re-direct output to function s_ouput.
    c:on("receive",function(c,l) 
      node.input(l)           
      --like pcall(loadstring(l)), support multiple separate lines
    end) 
    c:on("disconnection",function(c) 
      node.output(nil)        
      --unregist redirect output function, output goes to serial
    end) 
    print("Welcome to NodeMcu world.")
end)
```

Interfacing with sensor
```lua
-- read temperature with DS18B20
t=require("ds18b20")
t.setup(9)
addrs=t.addrs()
-- Total DS18B20 numbers, assume it is 2
print(table.getn(addrs))
-- The first DS18B20
print(t.read(addrs[1],t.C))
print(t.read(addrs[1],t.F))
print(t.read(addrs[1],t.K))
-- The second DS18B20
print(t.read(addrs[2],t.C))
print(t.read(addrs[2],t.F))
print(t.read(addrs[2],t.K))
-- Just read
print(t.read())
-- Just read as centigrade
print(t.read(nil,t.C))
-- Don't forget to release it after use
t = nil
ds18b20 = nil
package.loaded["ds18b20"]=nil
```



[^1]: Zeroday. "A lua based firmware for wifi-soc esp8266". Github. Retrieved 2 April 2015.
[^2]: Hari Wiguna. "NodeMCU LUA Firmware". Hackaday. Retrieved 2 April 2015.
[^3]: Systems, Espressif. "Espressif Systems". Espressif-WikiDevi. Retrieved 3 June 2017.
[^4]: Brian Benchoff. "A DEV BOARD FOR THE ESP LUA INTERPRETER". Hackaday. Retrieved 2 April 2015.
[^5]: Mpx. "Lua CJSON is a fast JSON encoding/parsing module for Lua". Github. Retrieved 2 April 2015.
[^6]: Pellepl. "Wear-leveled SPI flash file system for embedded devices". GitHub. Retrieved 2 April 2015.