---
layout: post
title: 'Heatmap demo' 
author: haeyeon.hwang
tags: [iot, hackathon, javascript]
description: >
  A heat map (or heatmap) is a graphical representation of data where the individual values contained in a matrix are represented as colors. "Heat map" is a newer term but shading matrices have existed for over a century. `wiki`
image: /assets/img/blog/heatmap.png
hide_image: true
---
{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **Heatmap Demo**

1. Reference [code](https://www.patrick-wied.at/static/heatmapjs/example-minimal-config.html) - heatmap.js

  * <a href="https://github.com/pushdown99/heatmap.git">source download <span class="icon-github"></span></a>
  <div class="heatmap-demo-block">
  <div class="heatmap-demo"></div>
  </div>
  <button class="heatmap-demo-btn">re-generate data</button>

  * run
  
  ~~~bash
  $ git clone https://github.com/pushdown99/heatmap.git
  $ cd heatmap
  $ python -m SimpleHTTPServer 1337 &
  ~~~

  * visit [http://localhost:1337/](http://localhost:1337/){: target="_blank" }
