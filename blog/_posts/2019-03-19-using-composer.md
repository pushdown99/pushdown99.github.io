---
layout: post
title: 'How to install and use composer' 
author: haeyeon.hwang
tags: [php]
description: >
  Enter Composer – a sleek and simple dependency manager for PHP. Some of you might already be familiar with similar dependency managers like PIP for Python or NPM for Node.js. Simply put, Composer will streamline all of your project’s dependencies in a single place.
image: /assets/img/blog/node.js.png
hide_image: true
---
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## [**How to install and use composer**](https://www.hostinger.com/tutorials/how-to-install-composer)
1. Install composer
   * installing composer on hostinger shared hosting   
    ~~~bash
    $ vi composer-installer.sh
    ~~~

    ~~~bash
    #!/bin/sh
    EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")
    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
    then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi
    php composer-setup.php --quiet
    RESULT=$?
    rm composer-setup.php
    ~~~

    ~~~bash
    $ sh composer-installer.sh
    $ composer
       ______
      / ____/___  ____ ___  ____  ____  ________  _____
     / /   / __ \/ __ `__ \/ __ \/ __ \/ ___/ _ \/ ___/
    / /___/ /_/ / / / / / / /_/ / /_/ (__  )  __/ /
    \____/\____/_/ /_/ /_/ .___/\____/____/\___/_/
                       /_/
    Composer version x.x.x YYYY-mm-dd HH:MM:SS
    ~~~

   * installing composer on Linux/MacOS   

    ~~~bash
    (local installation)
    $ php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    $ php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    $ php composer-setup.php --install-dir=bin --filename=composer
    $ php bin/composer

    (global installation after local installation)
    $ sudo mv composer.phar /usr/local/bin/composer
    $ composer
    ~~~

   * installing composer on Windows   
        [Download the latest composer version](https://getcomposer.org/Composer-Setup.exe), Install and Run

2. Generating and understanding `composer.json`
   * Create a new directory and enter

    ~~~bash
    $ mkdir phptimer
    $ cd phptimer
    ~~~

   * find a composer package or library at [packagist](https://packagist.org/)  
    ![packagist](https://www.hostinger.com/tutorials/wp-content/uploads/sites/2/2017/04/packagist.png){: width="60%"}    
 
   * install
 
    ~~~bash
    $ composer require phpunit/php-timer
    (composer will create two new files - `composer.json` and `composer.lock`)
    ~~~ 
  
3. Using autoload script  
 
    ~~~console
    require 'vendor/autoload.php'
    ~~~

    ~~~php
    require 'vendor/autoload.php'
    PHP_Timer::start();
    // your code
    $time = PHP_Timer::stop();
    var_dump($time);
    print PHP_Timer::secondsToTimeString($time)
    ~~~

4. Updating your project dependencies
 
    ~~~bash
    $ composer update 
    $ composer update vendor/package vendor2/package2
    ~~~

## **References**
* [How to Install and Use Composer](https://www.hostinger.com/tutorials/how-to-install-composer)
