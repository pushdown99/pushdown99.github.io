---
layout: post
title: 'Web Crawler Demo' 
author: haeyeon.hwang
tags: [speech-recognition, annyang, javascript]
description: >
  A Web crawler, sometimes called a spider or spiderbot and often shortened to crawler, is an Internet bot that systematically browses the World Wide Web, typically for the purpose of Web indexing (web spidering). `wiki`
image: /assets/img/blog/webcrawler.jpg
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **Web Crawler**

---

### 환경구성

구분|구성|비고
---|---|---
수집차트|멜론일간차트|[https://www.melon.com/chart/day/index.htm](https://www.melon.com/chart/day/index.htm)
웹크롤러|heroku/node.js|[https://get-chart.herokuapp.com/](https://get-chart.herokuapp.com/)
클라이언트|html5/jQuery|[http://127.0.0.1:4000/blog/2020-09-12-melon-chart/](http://127.0.0.1:4000/blog/2020-09-12-melon-chart/)

- node.js CORS (cross origin resource sharing) 문제 해결방법

  방안|해결방안|코드
  ---|---|---
  1|Access-Control-Allow-Origin response header 추가|<code>res.header("Access-Control-Allow-Origin", "*");</code>
  2|CORS middleware 추가|<code>app.use(cors());</code>

- Access-Control-Allow-Origin response header 추가
  ~~~javascript
  app.get('/data', (req, res) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.send(data);
  });
  ~~~

- CORS middleware 추가
  ~~~javascript
  const express = require('express');
  const cors    = require('cors');
  const app     = express();

  const corsOptions = {
    origin: 'http://localhost:3000', 
    credentials: true, 
  };
  app.use(cors(corsOptions)); 
  ~~~

### Chart Crawler

[https://get-chart.herokuapp.com/](https://get-chart.herokuapp.com/)

<script src="/assets/js/jquery-1.10.2.min.js"></script>

### 멜론차트 (Top50)
<div id='webcrawler-demo-block' class='container-fluid'>
  <div class="row">
    <div id="webcrawler-demo"></div>
  </div>
</div>

<script type='text/javascript'>

function webcrawler_getjson () {
  var url = 'https://get-chart.herokuapp.com/';
  
  $.getJSON(url, function (data) {
    var info = document.getElementById('webcrawler-demo');
    var h    =  '';
    
    h +=  '<table class="table">';
    h += '   <thead>';
    h += '    <tr>';
    h += '      <th scope="col">순위</th>';
    h += '      <th scope="col">앨범사진</th>';
    h += '      <th scope="col">타이틀</th>';
    h += '      <th scope="col">아티스트</th>';
    h += '    </tr>';
    h += '  </thead>';
    h += '  <tbody>';

    $.each(data, function (i, t) {
      h += '<tr>';
      h += '<td>' + t.rank +'</td>';
      h += '<td><img src="' + t.image +'/melon/resize/120/quality/80/optimize' + '"></td>';
      h += '<td>' + t.title +'</td>';
      h += '<td>' + t.artist +'</td>';
      h += '</tr>';
    });
    h += '  </tbody>';
    h +=  '</table>';
  
    info.innerHTML = h;
  });
}

jQuery(document).ready(function($) {
  webcrawler_getjson ();
});
</script>