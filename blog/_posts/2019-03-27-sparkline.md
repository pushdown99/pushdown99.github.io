---
layout: post
title: 'sparkline' 
author: haeyeon.hwang
tags: [speech-recognition, annyang, javascript]
image: /assets/img/blog/annyang.png
hide_image: true
---

## **sparkline**

https://omnipotent.net/jquery.sparkline/#s-about

~~~bash
$ vi index.html
~~~

~~~html
<html>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://omnipotent.net/jquery.sparkline/2.1.2/jquery.sparkline.min.js"></script>
<div id="sparkline" width="100px"></div>
<script>
$("#sparkline").sparkline([5,6,7,9,9,5,3,2,2,4,6,7], {
    type: 'line'
});
</script>
</body>
</html>
~~~

~~~bash
$ python -m SimpleHTTPServer 8000
~~~



https://github.com/fnando/sparkline

~~~bash
$ apt-get install npm
$ npm install @fnando/sparkline --save
~~~

