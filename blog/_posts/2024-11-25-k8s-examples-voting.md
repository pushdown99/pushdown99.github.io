---
layout: post
title: 'Kubernetes Exmaple App' 
author: haeyeon.hwang
tags: [Kubernetes, k8s]
description: >
  쿠버네티스 샘플 구성 
image: /assets/img/blog/k8s_sample_voting.png
hide_image: true
---

## Kubernetes 투표 샘플 코드

~~~console
git clone https://github.com/dockersamples/example-voting-app.git
cd example-voting-app
~~~

### 구조

#### [소스코드 디렉토리 구조](#source_directory_structure)

#### 주요 디렉토리 설명

주요디렉토리|개발언어|웹/프레임워크|설명
---|---|---|---
vote|python|Flask|web -> (vote) -> redis
result|nodejs|Express| db -> (result) -> web
worker|C#|| redis -> (worker) -> db
healthchecks|shell script||Redis, Postgres 동작 여부 체크
k8s-specifications|yaml||{vote, result, worker, redis, db} deployment 및 service 정의
seed-data|python||

#### vote: [Dockerfile](#vote_dockerfile), [app.py](#vote_app_py), [templates/index.html](#vote_index_html), [requirements.txt](#vote_requirements_txt)



~~~console
~~~

#### 아키텍처 구조

![k8s_sample_voting](/assets/img/blog/k8s_sample_voting.png)

### Docker 이미지 빌드

#### [docker-compose.yml 보기](#docker_compose)

#### Run in this directory to build and run the app

~~~console
docker compose up

[+] Running 18/20
 ✔ redis Pulled           17.7s 
   ✔ dd8d46bd4047 Pull complete            5.6s 
   ✔ 5057e26f1a86 Pull complete            6.9s 
   ✔ be83d0fd33a3 Pull complete            7.2s 
   ✔ b3d150cb1b6c Pull complete           12.0s 
   ✔ 369ad5b9119b Pull complete           12.5s 
   ✔ 4f4fb700ef54 Pull complete           12.8s 
[+] Running 18/20 Pull complete
 ✔ redis Pulled  
 ...                  
~~~

#### Run the App in Kubernetes

~~~console
kubectl create -f k8s-specifications/

deployment.apps/db created
service/db created
deployment.apps/redis created
service/redis created
deployment.apps/result created
service/result created
deployment.apps/vote created
service/vote created
deployment.apps/worker created
~~~

#### 서비스 확인 하기

~~~console
kubectl get services

NAME       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE
db         ClusterIP   10.111.236.182   <none>        5432/TCP                 3m50s
kube-dns   ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   13d
redis      ClusterIP   10.109.150.61    <none>        6379/TCP                 3m50s
result     NodePort    10.107.251.136   <none>        8081:31001/TCP           3m49s
vote       NodePort    10.110.254.188   <none>        8080:31000/TCP           3m49s
~~~

#### 서비스 접속하기 [http://127.0.0.1.31000](http://127.0.0.1.31000)

![k8s_sample_voting_view](/assets/img/blog/k8s_sample_voting_view.png)


#source_directory_structure

~~~console
├─.github
│  └─workflows
├─.vscode
├─healthchecks
├─k8s-specifications
├─result
│  ├─tests
│  └─views
│      └─stylesheets
├─seed-data
├─vote
│  ├─static
│  │  └─stylesheets
│  └─templates
└─worker
~~~

#docker_compose

~~~console
# version is now using "compose spec"
# v2 and v3 are now combined!
# docker-compose v1.27+ required

services:
  vote:
    build: 
      context: ./vote
      target: dev
    depends_on:
      redis:
        condition: service_healthy
    healthcheck: 
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 15s
      timeout: 5s
      retries: 3
      start_period: 10s
    volumes:
     - ./vote:/usr/local/app
    ports:
      - "8080:80"
    networks:
      - front-tier
      - back-tier

  result:
    build: ./result
    # use nodemon rather than node for local dev
    entrypoint: nodemon --inspect=0.0.0.0 server.js
    depends_on:
      db:
        condition: service_healthy 
    volumes:
      - ./result:/usr/local/app
    ports:
      - "8081:80"
      - "127.0.0.1:9229:9229"
    networks:
      - front-tier
      - back-tier

  worker:
    build:
      context: ./worker
    depends_on:
      redis:
        condition: service_healthy 
      db:
        condition: service_healthy 
    networks:
      - back-tier

  redis:
    image: redis:alpine
    volumes:
      - "./healthchecks:/healthchecks"
    healthcheck:
      test: /healthchecks/redis.sh
      interval: "5s"
    networks:
      - back-tier

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "postgres"
    volumes:
      - "db-data:/var/lib/postgresql/data"
      - "./healthchecks:/healthchecks"
    healthcheck:
      test: /healthchecks/postgres.sh
      interval: "5s"
    networks:
      - back-tier

  # this service runs once to seed the database with votes
  # it won't run unless you specify the "seed" profile
  # docker compose --profile seed up -d
  seed:
    build: ./seed-data
    profiles: ["seed"]
    depends_on:
      vote:
        condition: service_healthy 
    networks:
      - front-tier
    restart: "no"

volumes:
  db-data:

networks:
  front-tier:
  back-tier:
~~~

#vote_dockerfile 

~~~console
# base defines a base stage that uses the official python runtime base image
FROM python:3.11-slim AS base

# Add curl for healthcheck
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

# Set the application directory
WORKDIR /usr/local/app

# Install our requirements.txt
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# dev defines a stage for development, where it'll watch for filesystem changes
FROM base AS dev
RUN pip install watchdog
ENV FLASK_ENV=development
CMD ["python", "app.py"]

# final defines the stage that will bundle the application for production
FROM base AS final

# Copy our code from the current folder to the working directory inside the container
COPY . .

# Make port 80 available for links and/or publish
EXPOSE 80

# Define our command to be run when launching the container
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:80", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
~~~

#vote_app_py

~~~python
from flask import Flask, render_template, request, make_response, g
from redis import Redis
import os
import socket
import random
import json
import logging

option_a = os.getenv('OPTION_A', "Cats")
option_b = os.getenv('OPTION_B', "Dogs")
hostname = socket.gethostname()

app = Flask(__name__)

gunicorn_error_logger = logging.getLogger('gunicorn.error')
app.logger.handlers.extend(gunicorn_error_logger.handlers)
app.logger.setLevel(logging.INFO)

def get_redis():
    if not hasattr(g, 'redis'):
        g.redis = Redis(host="redis", db=0, socket_timeout=5)
    return g.redis

@app.route("/", methods=['POST','GET'])
def hello():
    voter_id = request.cookies.get('voter_id')
    if not voter_id:
        voter_id = hex(random.getrandbits(64))[2:-1]

    vote = None

    if request.method == 'POST':
        redis = get_redis()
        vote = request.form['vote']
        app.logger.info('Received vote for %s', vote)
        data = json.dumps({'voter_id': voter_id, 'vote': vote})
        redis.rpush('votes', data)

    resp = make_response(render_template(
        'index.html',
        option_a=option_a,
        option_b=option_b,
        hostname=hostname,
        vote=vote,
    ))
    resp.set_cookie('voter_id', voter_id)
    return resp


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80, debug=True, threaded=True)
~~~

#vote_requirements_txt
~~~console
Flask
Redis
gunicorn
~~~

WSGI (Web Server Gateway Interface): 웹 서버와 통신하기 위한 표준 인터페이스

![wsgi](/assets/img/blog/wsgi.png)

#vote_index_html

~~~html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>{{option_a}} vs {{option_b}}!</title>
    <base href="/index.html">
    <meta name = "viewport" content = "width=device-width, initial-scale = 1.0">
    <meta name="keywords" content="docker-compose, docker, stack">
    <meta name="author" content="Tutum dev team">
    <link rel='stylesheet' href="{{ url_for('static',filename='stylesheets/style.css') }}" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  </head>
  <body>
    <div id="content-container">
      <div id="content-container-center">
        <h3>{{option_a}} vs {{option_b}}!</h3>
        <form id="choice" name='form' method="POST" action="/">
          <button id="a" type="submit" name="vote" class="a" value="a">{{option_a}}</button>
          <button id="b" type="submit" name="vote" class="b" value="b">{{option_b}}</button>
        </form>
        <div id="tip">
          (Tip: you can change your vote)
        </div>
        <div id="hostname">
          Processed by container ID {{hostname}}
        </div>
      </div>
    </div>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>

    {% if vote %}
    <script>
      var vote = "{{vote}}";

      if(vote == "a"){
        $(".a").prop('disabled', true);
        $(".a").html('{{option_a}} <i class="fa fa-check-circle"></i>');
        $(".b").css('opacity','0.5');
      }
      if(vote == "b"){
        $(".b").prop('disabled', true);
        $(".b").html('{{option_b}} <i class="fa fa-check-circle"></i>');
        $(".a").css('opacity','0.5');
      }
    </script>
    {% endif %}
  </body>
</html>
~~~