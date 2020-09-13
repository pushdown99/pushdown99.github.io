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

## **웹크롤러 (Web Crawler)**

---

코드 레퍼런스: [https://codepen.io/desandro/pen/bdgRzg](https://codepen.io/desandro/pen/bdgRzg)


<link href="/assets/css/bootstrap-3.1.1.min.css" rel="stylesheet" type="text/css"/>
<link href="/assets/css/hydejack-8.4.0.css" rel="stylesheet" type="text/css"/>
<link href="/assets/css/owl.carousel.min.css" rel="stylesheet" type="text/css"/>

<script src="/assets/js/jquery-1.10.2.min.js"></script>
<script src="/assets/js/jquery-ui-1.10.4.min.js"></script>
<script src="/assets/js/bootstrap-3.1.1.min.js"></script>

<script src="/assets/js/owl.carousel.min.js"></script>

<div id='webcrawler-demo-block' class='container-fluid'>
  <div class="row">
    <div class="input-group input-group-lg">
      <input type="text" id="webcrawler-demo-input" class="form-control" placeholder="Search">
      <div class="input-group-btn">
        <button id="webcrawler-demo-btn" class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
      </div>
      <br>
    </div>
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

    $.each(data.photos.photo, function (i, t) {
      var image = 'https://farm' + t.farm + '.staticflickr.com/' + t.server + '/' + t.id + '_' + t.secret + '_n.jpg';
      h += '<tr>';
      h += '<td>' + t.rank +'</td>';
      h += '<td><img src="' + t.image +'"></td>';
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

  document.querySelector('#webcrawler-demo-btn').onclick = function() {
    webcrawler_getjson ();
  };
});
</script>