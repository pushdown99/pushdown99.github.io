---
layout: post
title: 'Stock Chart Demo' 
author: haeyeon.hwang
tags: [speech-recognition, annyang, javascript]
description: >
  Masonry is the building of structures from individual units, which are often laid in and bound together by mortar; the term masonry can also refer to the units themselves.
image: /assets/img/blog/masonry.jpg
hide_image: true
---

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **Stock Chart**

---

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<div id="chart"></div>

<script type='text/javascript'>

google.charts.load('visualization', { packages: ['corechart'] });
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

  $.getJSON('https://get-krx-chart.herokuapp.com/', function(json) {
    console.log(json);
    var ch = new google.visualization.DataTable();
    ch.addColumn('date', 't');
    ch.addColumn('number', 'price');
    var chart = new google.visualization.LineChart(document.getElementById('chart'));
    var options = { title: 'stock', fontName: 'Roboto Slab,Helvetica,Arial,sans-serif', curveType: 'function', legend: 'none', lineWidth: 5, vAxis: { viewWindowMode:'explicit'}};
    $.each(json, function (i, t) {
      var d = new Date(i*10/10);
      ch.addRow([d, t.Close]);
    });
    chart.draw(ch, options);
  });
}

</script>