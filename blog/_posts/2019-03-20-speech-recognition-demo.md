---
layout: post
title: 'annyang demo' 
author: haeyeon.hwang
tags: [speech-recognition, annyang, javascript]
image: /assets/img/blog/annyang.png
hide_image: true
---

## **Speech recognition demo**

<link href="/assets/css/bootstrap-3.1.1.min.css" rel="stylesheet" type="text/css"/>
<link href="/assets/css/hydejack-8.4.0.css" rel="stylesheet" type="text/css"/>

<script src="/assets/js/jquery-1.10.2.min.js"></script>
<script src="/assets/js/jquery-ui-1.10.4.min.js"></script>
<script src="/assets/js/bootstrap-3.1.1.min.js"></script>

<div class='annyang-demo-block container'>
  <div class='annyang-demo'></div>
</div>
<button class="annyang-demo-btn">speech recognition start</button>

  ~~~bash
  $ git clone https://github.com/pushdown99/annyang.git
  $ cd annyang
  $ python -m SimpleHTTPServer 1337 &
  ~~~

visit [http://localhost:1337/](http://localhost:1337/){: target="_blank" } 