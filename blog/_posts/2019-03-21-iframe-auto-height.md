---
layout: post
title: 'iFrame auto-height' 
author: haeyeon.hwang
tags: [speech-recognition, annyang, javascript]
image: /assets/img/blog/annyang.png
hide_image: true
---

## **iFrame auto-height**

Test

<iframe src="https://cors.io/?https://www.naver.com" id="myiframe" style="display:block; width:90vw; height: 100vh"></iframe>
 <script>
 $('#myiframe').load(function(){
     //then set up some access points
     var contents = $(this).contents(); // contents of the iframe
     $(contents).find("body").on('mouseup', function(event) { 
         alert('test'); 
     });
 });
 </script>