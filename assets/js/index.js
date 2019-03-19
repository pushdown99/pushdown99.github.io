/* global window */
(function (window, document, $) {
    'use strict';

    $(function () {
        // by default, blog menu is active unless page
        var activeMenu = $('#menu > li.active');
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
          container: document.querySelector('.demo-heatmap')
        });
        var data = generateRandomData(heatmap_element_num);
  
        heatmapInstance.setData(data);
  
        document.querySelector('.demo-btn').onclick = function() {
          heatmapInstance.setData(generateRandomData(heatmap_element_num));
        };
    });
}(window, window.document, window.jQuery));
