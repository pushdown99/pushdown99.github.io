---
layout: post
title: 'postgresql in heroku' 
author: haeyeon.hwang
tags: [speech-recognition, annyang, javascript]
image: /assets/img/blog/annyang.png
hide_image: true
---

## **Postgresql in heroku**

~~~bash
$ heroku pg:info
$ heroku pg:psql
~~~


~~~sql

create table cushion (
  uuid       varchar(16),
  ts         timestamp,
  ch0        smallint,
  ch1        smallint,
  ch2        smallint,
  ch3        smallint,
  ch4        smallint,
  ch5        smallint,
  ch6        smallint,
  ch7        smallint,
  ch8        smallint,
  ch9        smallint,
  ch10       smallint,
  ch11       smallint,
  ch12       smallint,
  ch13       smallint,
  ch14       smallint,
  ch15       smallint,
  ch16       smallint,
  ch17       smallint,
  ch18       smallint,
  ch19       smallint,
  ch20       smallint,
  ch21       smallint,
  ch22       smallint,
  ch23       smallint,
  ch24       smallint,
  ch25       smallint,
  ch26       smallint,
  ch27       smallint,
  ch28       smallint,
  ch29       smallint,
  ch30       smallint
);

create index iuuid on cushion(uuid);

~~~

https://lastminuteengineers.com/esp32-arduino-ide-tutorial/
https://randomnerdtutorials.com/esp32-access-point-ap-web-server/
https://arduinojson.org/v6/example/generator/

~~~c
#include <WiFi.h>

#define LED 2

String ssid     = "ESP32-AP-" + String(random(1111,9999));
String password = "1234567890";

WiFiServer server(80);

String header;

char* S2C(String s){
    if(s.length()!=0){
        char *p = const_cast<char*>(s.c_str());
        return p;
    }
}

void _initAP()
{
  Serial.println("softAP mode. ");
  pinMode(LED,OUTPUT);
  WiFi.softAP(S2C(ssid), S2C(password));
  IPAddress IP = WiFi.softAPIP();
  Serial.print("AP IP address: ");
  Serial.println(IP); 
  server.begin();
}

void setup() {
  Serial.begin(115200);
  _initAP();
}

void _softAP()
{
  WiFiClient client = server.available();   // Listen for incoming clients
  if (client) {                             // If a new client connects,
    Serial.println("New Client.");          // print a message out in the serial port
    String currentLine = "";                // make a String to hold incoming data from the client
    while (client.connected()) {            // loop while the client's connected
      if (client.available()) {             // if there's bytes to read from the client,
        char c = client.read();             // read a byte, then
        Serial.write(c);                    // print it out the serial monitor
        header += c;
        if (c == '\n') {                    // if the byte is a newline character
          if (currentLine.length() == 0) {
            client.println("HTTP/1.1 200 OK");
            client.println("Content-type:text/html");
            client.println("Connection: close");
            client.println();
            String payload = "";
            payload += "<!DOCTYPE html>";
            payload += "<html>";
            payload += "<body>";
            payload += "Helloworld";
            payload += "</body>";
            payload += "</html>\n\n";
            client.print(S2C(payload));
            /*
            client.println("<!DOCTYPE html><html>");
            client.println("<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
            client.println("<link rel=\"icon\" href=\"data:,\">");
            client.println("<style>html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}");
            client.println(".button { background-color: #4CAF50; border: none; color: white; padding: 16px 40px;");
            client.println("text-decoration: none; font-size: 30px; margin: 2px; cursor: pointer;}");
            client.println(".button2 {background-color: #555555;}</style></head>");
            client.println("<body><h1>ESP32 Web Server</h1>");
            client.println("</body></html>");
            client.println();
            */
          } else { // if you got a newline, then clear currentLine
            currentLine = "";
          }
        } else if (c != '\r') {  // if you got anything else but a carriage return character,
          currentLine += c;      // add it to the end of the currentLine
        }
      }
    }
    header = "";
    client.stop();
    Serial.println("Client disconnected.");
    Serial.println("");
  }
}

void loop(){
  _softAP();
}
~~~

https://github.com/prampec/IotWebConf
https://randomnerdtutorials.com/decoding-and-encoding-json-with-arduino-or-esp8266/
https://arduinojson.org/v5/assistant/


