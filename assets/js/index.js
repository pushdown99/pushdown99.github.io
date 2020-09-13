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

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        //
        // HEATMAP DEMO
        //
        if ($('.heatmap-demo-block').length > 0) {
            console.log($('.heatmap-demo-block'));

            var heatmap_element_num      = 100;
            function generateRandomData(num, w) 
            {
                console.log(w);
                var points = [];
                var max    = 0;
                var width  = w; 
                var height = 400;
                var len    = num;
  
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

            var demoblock = document.getElementById('demo-block');

            var data = generateRandomData(heatmap_element_num, demoblock.clientWidth);
            heatmapInstance.setData(data);

            document.querySelector('.heatmap-demo-btn').onclick = function() {
                heatmapInstance.setData(generateRandomData(heatmap_element_num, demoblock.clientWidth));
            };

            new ResizeSensor(demoblock, function() {
                console.log('Changed to ' + demoblock.clientWidth);
                heatmapInstance.setData(generateRandomData(heatmap_element_num, demoblock.clientWidth));
            });
        }

        /*
        var testurl = 'https://cors.io/?https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a828a6571bb4f0ff8890f7a386d61975&sort=interestingness-desc&per_page=30&format=json&callback=jsonFlickrApi&tags=boy';
https://cors-anywhere.herokuapp.com
        console.log(testurl);
        https://cors-anywhere.herokuapp.com/https://www.naver.com
        Missing required request header. Must specify one of: origin,x-requested-with
        $.getJSON(testurl, function(data) {
            console.log(data);
        });
        https://thingproxy.freeboard.io/fetch/https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a828a6571bb4f0ff8890f7a386d61975&sort=interestingness-desc&per_page=30&format=json&callback=jsonFlickrApi&tags=boy;
        https://nordicapis.com/10-free-to-use-cors-proxies/
        */

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        //
        // CORS DEMO
        //
        if ($('.cors-demo-block').length > 0) {
            console.log($('.cors-demo-block'));
            //var url = "https://thingproxy.freeboard.io/fetch/https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a828a6571bb4f0ff8890f7a386d61975&sort=interestingness-desc&per_page=30&format=json&callback=jsonFlickrApi&tags=boy"
            var url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a828a6571bb4f0ff8890f7a386d61975&sort=interestingness-desc&per_page=30&format=json&callback=jsonFlickrApi&tags=boy"
            $.getJSON( url, function( data ) {
                var items = [];
                $.each( data, function( i, t ) {
                    console.log(t);
                  //items.push( "<li id='" + key + "'>" + val + "</li>" );
                });
            });
        }        

        ///////////////////////////////////////////////////////////////////////////////////////////////////
        //
        // SPEACH RECOGNITION DEMO
        //
        if ($('.annyang-demo-block').length > 0) {
            console.log($('.annyang-demo-block'));

            var readyText  = 'Say "show me *"';
            var findText   = 'Finding... ';
    
            function showFlickr (tag) {
                SpeechKITT.setInstructionsText(findText+tag);
                var url = 'https://thingproxy.freeboard.io/?https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a828a6571bb4f0ff8890f7a386d61975&sort=interestingness-desc&per_page=30&format=json&callback=jsonFlickrApi&tags='+tag;
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
            getResult(JSON.parse(x.responseText));
        };
        x.send();
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Flickr DEMO
    //      
    if ($('#flickr-json-demo-block').length > 0) {
        console.log($('#flickr-json-demo-block'));
        var tag = 'boy';
        var key = 'a828a6571bb4f0ff8890f7a386d61975';
        var url = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key='+key+'&tags='+tag+'&safe_search=1&per_page=20'
        doCORSRequest("GET", url, function getResult(data) {
            var info = document.getElementById('flickr-json-demo');
            var h = '<div id="flickr-json-demo">';

            console.log(data);
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

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // getJSON DEMO
    //  
    if ($('#getjson-demo-block').length > 0) {
        console.log($('#getjson-demo-block'));
        function getjson_flickr(tag) {
            var key = 'a828a6571bb4f0ff8890f7a386d61975';
            var url = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=' + key + '&tags=' + tag + '&safe_search=1&per_page=20'
  
            $.getJSON(url, function (data) {
                var info = document.getElementById('getjson-demo');
                var h = '<div id="getjson-demo">';

                $.each(data.photos.photo, function (i, t) {
                    var image = 'https://farm' + t.farm + '.staticflickr.com/' + t.server + '/' + t.id + '_' + t.secret + '_n.jpg';
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
        document.querySelector('#getjson-demo-btn').onclick = function() {
            getjson_flickr(document.querySelector('#getjson-demo-input').value);
        };
        $('#getjson-demo-input').keyup(function(e) {
            if (e.keyCode == 13)   getjson_flickr(document.querySelector('#getjson-demo-input').value);       
        });
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // MASONRY DEMO
    //   
    if ($('#masonry-demo-block').length > 0) {
        console.log($('#masonry-demo-block'));
        function masonry_getjson_flickr(tag) {
            var key = 'a828a6571bb4f0ff8890f7a386d61975';
            var url = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=' + key + '&tags=' + tag + '&safe_search=1&per_page=20'
  
            $.getJSON(url, function (data) {
                var info = document.getElementById('masonry-demo');
                var h = '<div class="grid-sizer"></div>';

                $.each(data.photos.photo, function (i, t) {
                    var image = 'https://farm' + t.farm + '.staticflickr.com/' + t.server + '/' + t.id + '_' + t.secret + '_n.jpg';
                    h += '<div class="grid-item">';
                    h += '  <a href="' + image + '" target=_blank">';
                    h += '      <img src="' + image + '" class="img-responsive" alt="">';
                    h += '  </a>';
                    // h += t.title;
                    h += '</div>';
                });
                info.innerHTML = h;
          });
        }
        document.querySelector('#masonry-demo-btn').onclick = function() {
            masonry_getjson_flickr(document.querySelector('#masonry-demo-input').value);
        };
        $('#masonry-demo-input').keyup(function(e) {
            if (e.keyCode == 13)   masonry_getjson_flickr(document.querySelector('#masonry-demo-input').value);       
        });
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // CAROUSEL DEMO
    //   
    if ($('#carousel-demo-block').length > 0) {
        console.log($('#carousel-demo-block'));


/*
        function carousel_getjson_flickr(tag) {
            var key = 'a828a6571bb4f0ff8890f7a386d61975';
            var url = 'https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=' + key + '&tags=' + tag + '&safe_search=1&per_page=20'
  
            $.getJSON(url, function (data) {
                var info = document.getElementById('carousel-demo');
                var h = '';

                $.each(data.photos.photo, function (i, t) {
                    var image = 'https://farm' + t.farm + '.staticflickr.com/' + t.server + '/' + t.id + '_' + t.secret + '_n.jpg';
                    h += '<div class="item">';
                    h += '      <img src="' + image + '" class="img-responsive" alt="">';
                    h += '</div>';
                });
                info.innerHTML = h;
          });
        }
        document.querySelector('#carousel-demo-btn').onclick = function() {
            carousel_getjson_flickr(document.querySelector('#carousel-demo-input').value);
            //carousel_update ();
        };
        $('#carousel-demo-input').keyup(function(e) {
            if (e.keyCode == 13) {
                carousel_getjson_flickr(document.querySelector('#carousel-demo-input').value);       
                //carousel_update ();
            }
        });
*/
    }

}(window, window.document, window.jQuery));
