---
layout: post
title: 'getJSON flicker' 
author: haeyeon.hwang
tags: [speech-recognition, annyang, javascript]
image: /assets/img/blog/annyang.png
hide_image: true
---

## **getJSON at github page**

~~~console
jQuery.getJSON(url [,data][,success])
~~~

<link href="/assets/css/bootstrap-3.1.1.min.css" rel="stylesheet" type="text/css"/>
<link href="/assets/css/hydejack-8.4.0.css" rel="stylesheet" type="text/css"/>

<script src="/assets/js/jquery-1.10.2.min.js"></script>
<script src="/assets/js/jquery-ui-1.10.4.min.js"></script>
<script src="/assets/js/bootstrap-3.1.1.min.js"></script>

 <div id='getjson-demo-block' class='container-fluid'>
  <div class="row">
    <div class="input-group input-group-lg">
      <input type="text" id="getjson-demo-input" class="form-control" placeholder="Search">
      <div class="input-group-btn">
        <button id="getjson-demo-btn" class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
      </div>
    </div>
    <br><br>
    <div id='getjson-demo'></div>
  </div>
</div>