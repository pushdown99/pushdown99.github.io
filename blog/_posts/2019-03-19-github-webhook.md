---
layout: post
title: 'Using github webhook' 
author: haeyeon.hwang
tags: [github, php]
description: >
  Webhooks allow you to build or set up integrations, such as GitHub Apps or OAuth Apps, which subscribe to certain events on GitHub.com.  `github`
image: /assets/img/blog/node.js.png
hide_image: true
---
{:.no_toc}
0. this unordered seed list will be replaced by toc as unordered list
{:toc}

## **Getting started with Github webhook**
1. Read a [Github API](http://developer.github.com/v3/repos/hooks/)
2. Build a webhook server/script
    * install [PHP GitHub webhook](https://github.com/dintel/php-github-webhook) - PHP example
    * install webhook server [using composer][composer]  

    ~~~php
    <?php
    require(__DIR__ . "/vendor/autoload.php");
    use GitHubWebhook\Handler;

    $handler = new Handler("<your secret>", __DIR__);
    if($handler->handle()) {
        echo "OK";
    } else {
        echo "Wrong secret";
    }
    ~~~     
3. Register webhook service at github project
    ![webhook](https://github.com/alexandru/github-webhook-listener/wiki/setup.png){: width="60%" }   

    Settings > Webhooks & services > Add webhook

    item|description
    ---|---
    Payload URL|Enter full URL to your webhook script
    Content type|Can be either "application/json" or "application/x-www-form-urlencoded"
    Secret|Same secret you pass to constructor of Handler object

    PHP GitHub webhook handler  

    function|description
    ---|---
    __construct($secret, $gitDir, $remote = null)|Constructor. Constructs new webhook handler that will verify that requests coming to it are signed with $secret. $gitDir must be set to path to git repo that must be updated. Optional $remote specifies which remote should be pulled.
    getData()|Getter. After successful validation returns parsed array of data in payload. Otherwise returns null.
    getDelivery()|Getter. After successful validation returns unique delivery number coming from GitHub. Otherwise returns null.
    getEvent()|Getter. After successful validation returns name of event that triggered this webhook. Otherwise returns null.
    getGitDir()|Getter. Returns $gitDir that was passed to constructor.
    getGitOutput|Getter. After successful validation returns output of git as array of lines. Otherwise returns null.
    getRemote()|Getter. Returns $remote that was passed to constructor.
    getSecret()|Getter. Returns $secret that was passed to constructor.
    handle()|Handle the request. Validates that incoming request is signed correctly with $secret and executes git pull upon successful validation. Returns true on succes or false if validation failed.
    validate()|Validate request only. Returns boolean that indicates whether the request is correctly signed by $secret.

## **References**
* [Interworking between slack and github webhook](https://www.44bits.io/ko/post/notifying-github-event-by-using-github-webhook)
* [PHP GitHub webhook package](https://github.com/dintel/php-github-webhook.git)
* [Github developer - Webhooks](https://developer.github.com/v3/repos/hooks/)
* [Webhook listener](https://github.com/alexandru/github-webhook-listener/wiki/Setup)

[composer]: ../2013-03-19-using-composer