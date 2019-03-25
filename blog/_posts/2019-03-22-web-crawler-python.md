---
layout: post
title: 'web crawler, python' 
author: haeyeon.hwang
tags: [speech-recognition, annyang, javascript]
image: /assets/img/blog/annyang.png
hide_image: true
---

## **Web crawler, python**

https://beomi.github.io/2017/01/20/HowToMakeWebCrawler/
https://beomi.github.io/2017/02/27/HowToMakeWebCrawler-With-Selenium/


~~~bash
\> pip install requests
~~~

~~~python
import requests

req = requests.get('https://www.melon.com/chart/index.htm')
html = req.text
header = req.headers
status = req.status_code
is_ok = req.ok
~~~

~~~bash
\> pip install bs4
~~~

~~~python
import requests
from bs4 import BeautifulSoup

# HTTP GET Request
req = requests.get('https://www.melon.com/chart/index.htm')
html = req.text
soup = BeautifulSoup(html, 'html.parser')
titles = soup.select("div.ellipsis.rank01 > span > a")
for title in titles:
    print(title.text)

~~~

