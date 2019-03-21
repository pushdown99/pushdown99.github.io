/* global window */
(function (window, document, $) {
    'use strict';

    $(function () {
        // by default, blog menu is active unless page
        var activeMenu = $('#menu > li.active');

        console.log(activeMenu);

        if (activeMenu.length === 0) {
            activeMenu.removeClass('active');
            if ($(document.body).hasClass('page')) {
                $('#menu > li:nth-child(2)').addClass('active');
            } else {
                $('#menu > li:first-child').addClass('active');
            }
        }

        $('#menu-toggle').click(function (e) {
            e.stopPropagation();
            e.preventDefault();
            if ($('#menu').is(':visible')) {
                $('#menu').hide();
            } else {
                $('#search').hide();
                $('#menu').show();
            }
        });

        $('#search-toggle').click(function (e) {
            e.stopPropagation();
            e.preventDefault();
            if ($('#search').is(':visible')) {
                $('#search').hide();
            } else {
                $('#menu').hide();
                $('#search').show();
            }
        });

        $(window).scroll(function () {
            var viewportTop = $(window).scrollTop();
            //$('#back-to-top').css('display', 'inline');
            $('#back-to-top').show();

            if(viewportTop == 0) $('#back-to-top').hide();
        });

        // show/hide cover videos by browser
        var coverVideos = $('#cover video');
        if (/Mobi/.test(window.navigator.userAgent)) {
            coverVideos.remove();
        } else {
            coverVideos.click(function (e) {
                var v = e.target;
                if (v.paused) {
                    v.play();
                } else {
                    v.pause();
                }
            }).each(function (i, v) {
                v.play();
            }).show();
        }

        // turn img alt into caption
        $('#post-content > p > img[alt]').replaceWith(function () {
            return '<figure>'
                + '<a href="' + $(this).attr('src') + '" class="mg-link">'
                + '<img src="' + $(this).attr('src') + '"/></a>'
                + '<figcaption class="caption">' + $(this).attr('alt') + '</figcaption>'
                + '</figure>';
        });
        // and connect magnific popup image viewer
        $('#post-content .mg-link').magnificPopup({
            type: 'image',
            closeOnContentClick: true
        });

        console.log($('.heatmap-demo-block'));
        if ($('.heatmap-demo-block').length > 0) {
            var heatmap_element_num      = 500;

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
                container: document.querySelector('.heatmap-demo')
            });

            var data = generateRandomData(heatmap_element_num);
            heatmapInstance.setData(data);

            document.querySelector('.heatmap-demo-btn').onclick = function() {
                heatmapInstance.setData(generateRandomData(heatmap_element_num));
            };
        }

        var testurl = 'https://cors.io/?https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a828a6571bb4f0ff8890f7a386d61975&sort=interestingness-desc&per_page=30&format=json&callback=jsonFlickrApi&tags=boy';

        console.log(testurl);
        $.getJSON(testurl, function(data) {
            console.log(data);
        });

        console.log($('.annyang-demo-block'));
        if ($('.annyang-demo-block').length > 0) {
            var readyText  = 'Say "show me cute kittens"';
            var findText   = 'Finding... ';
    
            function showFlickr (tag) {
                SpeechKITT.setInstructionsText(findText+tag);
                var url = 'https://cors.io/?https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a828a6571bb4f0ff8890f7a386d61975&sort=interestingness-desc&per_page=30&format=json&nojsoncallback=1&tags='+tag;
                $.ajax({
                    type: 'GET',
                    url: url,
                    async: false,
                    jsonpCallback: 'jsonFlickrApi',
                    contentType: "application/json",
                    dataType: 'jsonp'
                });
            }
    
            function jsonFlickrApi (data) {
                var info = document.getElementByClassName('annyang-demo');
                var h = '<div class="annyang-demo">';
    
                $.each(data.photos.photo, function(i, t) {
                    console.log(t);
                    var image = '//farm'+t.farm+'.staticflickr.com/'+t.server+'/'+t.id+'_'+t.secret+'_n.jpg';
                    h += '<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">';
                    h += '  <a href="' + image + '" target=_blank">';
                    h += '      <img src="' + image + '" class="img-responsive" alt="">';
                    h += '  </a>';
                    h += t.title;
                    h += '<br><br><br>';
                    h += '</div>';
                });
                info.innerHTML = h;
                SpeechKITT.setInstructionsText(readyText);
            }
    
            function doSpeechRecognition() {
                console.log("annyang");
                console.log(annyang);
       
                var commands = {
                    'show me *search':      showFlickr
                }
                annyang.addCommands(commands);
                SpeechKITT.annyang();
                SpeechKITT.setAbortCommand(annyang.abort);
                SpeechKITT.setStylesheet('/assets/css/flat.css');
                SpeechKITT.setInstructionsText(readyText);
                //SpeechKITT.setSampleCommands(['show me cute kittens', 'show me *']);
                SpeechKITT.vroom();
                SpeechKITT.show();
            }

            document.querySelector('.annyang-demo-btn').onclick =  function() {
                doSpeechRecognition();
            };
        }
    });

    function doCORSRequest(method, url, getResult) {
        var cors_api_url = 'https://cors-anywhere.herokuapp.com/';
        var x = new XMLHttpRequest();
        console.log(x);
        x.open(method, cors_api_url + url);
        x.onload = x.onerror = function () {
            console.log(x.responseText); //
            getResult(x.responseText);
        };
        x.send();
    }

    console.log($('#flickr-json-demo-block'));
    if ($('#flickr-json-demo-block').length > 0) {
        var tag = "boy"
        var url = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a828a6571bb4f0ff8890f7a386d61975&sort=interestingness-desc&per_page=30&format=json&callback=jsonFlickrApi&tags='+tag;
        doCORSRequest("GET", url, function getResult(data) {
            var info = document.getElementById('flickr-json-demo');
            var h = '<div id="flickr-json-demo">';

            $.each(data.photos.photo, function(i, t) {
                console.log(t);
                var image = 'https://farm'+t.farm+'.staticflickr.com/'+t.server+'/'+t.id+'_'+t.secret+'_n.jpg';
                h += '<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">';
                h += '  <a href="' + image + '" target=_blank">';
                h += '      <img src="' + image + '" class="img-responsive" alt="">';
                h += '  </a>';
                h += t.title;
                h += '<br><br><br>';
                h += '</div>';
            });
            info.innerHTML = h;
        });
    }

}(window, window.document, window.jQuery));
