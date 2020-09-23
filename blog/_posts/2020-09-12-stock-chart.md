---
layout: post
title: 'Stock Chart Demo' 
author: haeyeon.hwang
tags: [visualization, chart, stock, finance, javascript]
description: >
  Google Charts is an interactive Web service that creates graphical charts from user-supplied information `wiki`
image: /assets/img/blog/google-chart.jpg
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

<div id='chart-demo-block' class='container-fluid'>
  <div class="row">
    <div id="chart"></div>
    <div id="table"></div>
  </div>
</div>

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

    var info = document.getElementById('table');
    var html = '<table>';
    html += '<thead>';
    html += '<tr>';
    html += '<th>Date</th>';
    html += '<th>High</th>';
    html += '<th>Low</th>';
    html += '<th>Open</th>';
    html += '<th>Close</th>';
    html += '<th>Close(adj)</th>';
    html += '<th>Volume</th>';

    html += '<th>Range(p)</th>';
    html += '<th>Range(t)</th>';
    html += '<th>Signal</th>';
    html += '<th>Buy</th>';
    html += '<th>Revenue</th>';
    html += '<th>Balance</th>';
    html += '</tr>';
    html += '</thead>';

    var Range   = 0;
    var Buy     = 0;
    var Balance = 0;

    html += '<tbody>';
    $.each(json, function (i, t) {
      var d = new Date(i*10/10).toISOString().split("T")[0];
      var High    = t.High;
      var Low     = t.Low;
      var Open    = t.Open;
      var Revenue = 0;
      var Signal  = parseInt(((Open + Range * 0.6))/100)*100;


      html += '<tr>';
      html += '<th>'+d+'</th>';
      html += '<th>'+t.High+'</th>';
      html += '<th>'+t.Low+'</th>';
      html += '<th>'+t.Open+'</th>';
      html += '<th>'+t.Close+'</th>';
      html += '<th>'+t['Adj Close']+'</th>';
      html += '<th>'+t.Volume+'</th>';

      if(Buy > 0) {
        Revenue = (Open - Buy)  
        Balance += Revenue;
        Buy = 0;
      }

      if(High > Signal) {
        Buy = Signal;
      }


      html += '<th>'+Range+'</th>';
      html += '<th>'+(High-Low)+'</th>';
      html += '<th>'+Signal+'</th>';
      html += '<th>'+Buy+'</th>';
      html += '<th>'+Revenue+'</th>';
      html += '<th>'+Balance+'</th>';
      html += '</tr>';

      Range = High - Low;
    });
    html += '</tbody>';
    html += '</table>';
    info.innerHTML = html;
  });
}

</script>