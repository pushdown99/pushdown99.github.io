---
layout: post
title: 'PhantomJS demo' 
author: haeyeon.hwang
tags: [iot, hackathon, javascript]
description: >
  PhantomJS is a discontinued headless browser used for automating web page interaction. PhantomJS provides a JavaScript API enabling automated navigation, screenshots, user behavior and assertions making it a common tool used to run browser-based unit tests in a headless system like a continuous integration environment.  `wiki`
image: /assets/img/blog/hackathon.png
hide_image: true
---
{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **PhantomJS Demo**

1. Reference [code](https://www.patrick-wied.at/static/heatmapjs/example-minimal-config.html) - heatmap.js

  * <a href="https://github.com/pushdown99/heatmap.git">source download <span class="icon-github"></span></a>
  <div class="cors-demo-block" id="cors-block">
    <div class="cors-demo"><iframe id="cors-iframe" src="http://thingproxy.freeboard.io/fetch/http://debian.tric.kr" width="100%" height="400" frameborder="1" scrolling="no"></iframe></div>
  </div>
  https:// <input type="text" value="hello">

  * run
  
  ~~~bash
  $ git clone https://github.com/pushdown99/heatmap.git
  $ cd heatmap
  $ python -m SimpleHTTPServer 1337 &
  ~~~

  * visit [http://localhost:1337/](http://localhost:1337/){: target="_blank" }
