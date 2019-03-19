---
layout: post
title: 'Bedsore prevention mat' 
author: haeyeon.hwang
tags: [iot, hackathon]
description: >
  The air mattress that prevents patients from developing pressure ulcers (bedsores), thereby improving their quality of life (QOL), promoting their rehabilitation, and reducing the burden of caregivers when changing a patient’s body position. `wiki`
image: /assets/img/blog/bedsore-prevention-mat.png
hide_image: true
---
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## [Heatmap](https://github.com/pa7/heatmap.js)

1. How to get started 
  * [install Node.js][nodejs]
  * install heatmap.js with bower
  
      ~~~bash
      > npm install -g bower
      > bower install -g heatmap.js-amd
      ~~~
  
  * Start a webserver

      ~~~bash
      > cd bower_components\heatmap.js-amd
      > python -m SimpleHTTPServer 1337 &
      ~~~

  * Then browse to [http://localhost:1337/examples/](http://localhost:1337/examples/)

2. [Examples](https://www.patrick-wied.at/static/heatmapjs/examples.html)

3. [Coding](https://github.com/pushdown99/heatmap/) 
  * Javascript
     
    ~~~js
    window.onload = function() {
      function generateRandomData(len) {
        var points = [];
        var max    = 0;
        var width  = 840;
        var height = 400;
        var len    = 200;

        while(len--) {
          var val = Math.floor(Math.random()*100);
          max = Math.max(max, val);
          var point = {
            x: Math.floor(Math.random()*width),
            y: Math.floor(Math.random()*height),
            value: val
          };
          points.push(point);
        }
        var data = {max:max, data: points};
        return data;
      }
      var heatmapInstance = h337.create({
        container: document.querySelector('.heatmap')
      });
      var data = generateRandomData(200);
      heatmapInstance.setData(data);
    }
    ~~~

   * Result  
    ![heatmap](/assets/img/blog/heatmap.png){: width="50%"}

4. [Demo][demo] 

[nodejs]: ../2019-03-19-getting-started-with-node-js
[demo]: ../2019-03-19-heatmap-demo