---
layout: post
title: 'Free https certification' 
author: haeyeon.hwang
tags: [iot, hackathon]
description: >
  To enable HTTPS on your website, you need to get a certificate (a type of file) from a Certificate Authority (CA). Let’s Encrypt is a CA. In order to get a certificate for your website’s domain from Let’s Encrypt, you have to demonstrate control over the domain. `Let's Encrypt`
image: /assets/img/blog/node.js.png
hide_image: true
---
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **Getting started with Let's Encrypt**
1. [Lookup site](https://letsencrypt.org/getting-started/)
2. Using [Cerbot](https://certbot.eff.org/) ACME client  
3. Example - Apache / Ubuntu 16.04
    * Install
    ~~~bash
    $ sudo apt-get update
    $ sudo apt-get install software-properties-common
    $ sudo add-apt-repository universe
    $ sudo add-apt-repository ppa:certbot/certbot
    $ sudo apt-get update
    $ sudo apt-get install certbot python-certbot-apache
    ~~~

    * Get started  
    ~~~bash
    $ sudo certbot --apache // auto
    or
    $ sudo certbot --apache certonly  // manual setting
    ~~~

    * Automating renewal 
    ~~~bash
    $ sudo certbot renew --dry-run
    or
    $ crontab -e 
    0 0 * * * /usr/bin/certbot renew --dry-run  // register to cron table
    ~~~

4. Exception/Error occurred
    * Run error: "'module' object has no attribute 'SSL_ST_INIT'"  
    ~~~bash    
    $ rm -rf /usr/lib/python2.7/dist-packages/OpenSSL
    $ rm -rf /usr/lib/python2.7/dist-packages/pyOpenSSL-0.15.1.egg-info
    $ sudo pip install pyopenssl
    ~~~
