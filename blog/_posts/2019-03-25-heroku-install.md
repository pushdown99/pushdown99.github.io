---
layout: post
title: 'heroku install' 
author: haeyeon.hwang
tags: [speech-recognition, annyang, javascript]
image: /assets/img/blog/annyang.png
hide_image: true
---

## **heroku install**

1. Install the Heroku CLI  
    Download and install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-command-line).

    If you haven't already, log in to your Heroku account and follow the prompts to create a new SSH public key.

    ~~~bash
    $ heroku login
    ~~~

2. Create a new Git repository
    Initialize a git repository in a new or existing directory

    ~~~bash
    $ cd my-project/
    $ git init
    $ heroku git:remote -a mbed-iot
    ~~~

3. Deploy your application  
    Commit your code to the repository and deploy it to Heroku using Git.

    ~~~bash
    $ git add .
    $ git commit -am "make it better"
    $ git push heroku master
    ~~~

4. Run your application
   
   ~~~bash
   $ heroku open
   ~~~

5. Existing Git repository  
    For existing repositories, simply add the heroku remote

    ~~~bash
    $ heroku git:remote -a mbed-iot
    ~~~

Ubuntu

~~~bash
$ sudo wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
$ heroku login -i
Email:
Password:
~~~

https://devcenter.heroku.com/articles/heroku-postgresql

Resources > Add-ons > Heroku Postgres
heroku logs --tail

https://docs.appery.io/docs/apiexpress-databaseconnection-heroku-postgres

https://www.pgadmin.org/download/pgadmin-3-windows/

heroku pg:psql postgresql-pointy-76099 

$ heroku logs -t
$ heroku pg:info
$ heroku pg:psql



http://www.mnlsolution.com/heroku/mbed-iot/hook/ifttt/
https://mbed-iot.herokuapp.com/hook/ifttt/

https://gist.github.com/milo/daed6e958ea534e4eba3

http://blog.weirdx.io/post/9008
https://devcenter.heroku.com/articles/getting-started-with-python
https://realpython.com/flask-by-example-part-1-project-setup/
