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

주요디렉토리|개발언어/웹/프레임워크|설명
---|---|---
vote|python, Flask|web->vote->redis
result|nodejs, Express|db->result-> web
worker|C#|redis->worker-> db
healthchecks|shell script|Redis, Postgres 동작 여부 체크
k8s-specifications|yaml|{vote, result, worker, redis, db} deployment 및 service 정의
seed-data|python|

#### 서비스 별, 주요 파일 정보

서비스|주요파일
---|---
vote|[Dockerfile](#vote_dockerfile), [app.py](#vote_app_py), [templates/index.html](#vote_index_html),  [requirements.txt](#vote_requirements_txt)
result|[Dockerfile](#result_dockerfile), [package.json](#result_package_json), [server.js](#result_server_js), [index.html](#result_index_html)
worker|,[Dockerfile](#worker_dockerfile), [program.cs](#worker_program_cs), [worker.csproj](#worker_cs_project)




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

~~~yaml
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

~~~docker
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

#result_dockerfile

~~~docker
FROM node:18-slim

# add curl for healthcheck
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl tini && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/app

# have nodemon available for local dev use (file watching)
RUN npm install -g nodemon

COPY package*.json ./

RUN npm ci && \
 npm cache clean --force && \
 mv /usr/local/app/node_modules /node_modules

COPY . .

ENV PORT=80
EXPOSE 80

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "server.js"]
~~~

#result_package_json

~~~json
{
  "name": "result",
  "version": "1.0.0",
  "description": "",
  "main": "server.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "MIT",
  "dependencies": {
    "async": "^3.1.0",
    "cookie-parser": "^1.4.6",
    "express": "^4.18.2",
    "method-override": "^3.0.0",
    "pg": "^8.8.0",
    "socket.io": "^4.7.2",
    "stoppable": "^1.1.0"
  }
}
~~~

#result_server_js

~~~javascript
var express = require('express'),
    async = require('async'),
    { Pool } = require('pg'),
    cookieParser = require('cookie-parser'),
    app = express(),
    server = require('http').Server(app),
    io = require('socket.io')(server);

var port = process.env.PORT || 4000;

io.on('connection', function (socket) {

  socket.emit('message', { text : 'Welcome!' });

  socket.on('subscribe', function (data) {
    socket.join(data.channel);
  });
});

var pool = new Pool({
  connectionString: 'postgres://postgres:postgres@db/postgres'
});

async.retry(
  {times: 1000, interval: 1000},
  function(callback) {
    pool.connect(function(err, client, done) {
      if (err) {
        console.error("Waiting for db");
      }
      callback(err, client);
    });
  },
  function(err, client) {
    if (err) {
      return console.error("Giving up");
    }
    console.log("Connected to db");
    getVotes(client);
  }
);

function getVotes(client) {
  client.query('SELECT vote, COUNT(id) AS count FROM votes GROUP BY vote', [], function(err, result) {
    if (err) {
      console.error("Error performing query: " + err);
    } else {
      var votes = collectVotesFromResult(result);
      io.sockets.emit("scores", JSON.stringify(votes));
    }

    setTimeout(function() {getVotes(client) }, 1000);
  });
}

function collectVotesFromResult(result) {
  var votes = {a: 0, b: 0};

  result.rows.forEach(function (row) {
    votes[row.vote] = parseInt(row.count);
  });

  return votes;
}

app.use(cookieParser());
app.use(express.urlencoded());
app.use(express.static(__dirname + '/views'));

app.get('/', function (req, res) {
  res.sendFile(path.resolve(__dirname + '/views/index.html'));
});

server.listen(port, function () {
  var port = server.address().port;
  console.log('App running on port ' + port);
});
~~~

#result_index_html

~~~html
<!DOCTYPE html>
<html ng-app="catsvsdogs">
  <head>
    <meta charset="utf-8">
    <title>Cats vs Dogs -- Result</title>
    <base href="/index.html">
    <meta name = "viewport" content = "width=device-width, initial-scale = 1.0">
    <meta name="keywords" content="docker-compose, docker, stack">
    <meta name="author" content="Docker">
    <link rel='stylesheet' href='/stylesheets/style.css' />
  </head>
  <body ng-controller="statsCtrl" >
     <div id="background-stats">
       <div id="background-stats-1">
       </div><!--
      --><div id="background-stats-2">
      </div>
    </div>
    <div id="content-container">
      <div id="content-container-center">
        <div id="choice">
          <div class="choice cats">
            <div class="label">Cats</div>
            <div class="stat">{{aPercent | number:1}}%</div>
          </div>
          <div class="divider"></div>
          <div class="choice dogs">
            <div class="label">Dogs</div>
            <div class="stat">{{bPercent | number:1}}%</div>
          </div>
        </div>
      </div>
    </div>
    <div id="result">
      <span ng-if="total == 0">No votes yet</span>
      <span ng-if="total == 1">{{total}} vote</span>
      <span ng-if="total >= 2">{{total}} votes</span>
    </div>
    <script src="socket.io.js"></script>
    <script src="angular.min.js"></script>
    <script src="app.js"></script>
  </body>
</html>
~~~

#worker_dockerfile

~~~docker
# because of dotnet, we always build on amd64, and target platforms in cli
# dotnet doesn't support QEMU for building or running. 
# (errors common in arm/v7 32bit) https://github.com/dotnet/dotnet-docker/issues/1537
# https://hub.docker.com/_/microsoft-dotnet
# hadolint ignore=DL3029
# to build for a different platform than your host, use --platform=<platform>
# for example, if you were on Intel (amd64) and wanted to build for ARM, you would use:
# docker buildx build --platform "linux/arm64/v8" .

# build compiles the program for the builder's local platform
FROM --platform=${BUILDPLATFORM} mcr.microsoft.com/dotnet/sdk:7.0 AS build
ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

WORKDIR /source
COPY *.csproj .
RUN dotnet restore -a $TARGETARCH

COPY . .
RUN dotnet publish -c release -o /app -a $TARGETARCH --self-contained false --no-restore

# app image
FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Worker.dll"]
~~~

#worker_program_cs

~~~cs
using System;
using System.Data.Common;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Threading;
using Newtonsoft.Json;
using Npgsql;
using StackExchange.Redis;

namespace Worker
{
    public class Program
    {
        public static int Main(string[] args)
        {
            try
            {
                var pgsql = OpenDbConnection("Server=db;Username=postgres;Password=postgres;");
                var redisConn = OpenRedisConnection("redis");
                var redis = redisConn.GetDatabase();

                // Keep alive is not implemented in Npgsql yet. This workaround was recommended:
                // https://github.com/npgsql/npgsql/issues/1214#issuecomment-235828359
                var keepAliveCommand = pgsql.CreateCommand();
                keepAliveCommand.CommandText = "SELECT 1";

                var definition = new { vote = "", voter_id = "" };
                while (true)
                {
                    // Slow down to prevent CPU spike, only query each 100ms
                    Thread.Sleep(100);

                    // Reconnect redis if down
                    if (redisConn == null || !redisConn.IsConnected) {
                        Console.WriteLine("Reconnecting Redis");
                        redisConn = OpenRedisConnection("redis");
                        redis = redisConn.GetDatabase();
                    }
                    string json = redis.ListLeftPopAsync("votes").Result;
                    if (json != null)
                    {
                        var vote = JsonConvert.DeserializeAnonymousType(json, definition);
                        Console.WriteLine($"Processing vote for '{vote.vote}' by '{vote.voter_id}'");
                        // Reconnect DB if down
                        if (!pgsql.State.Equals(System.Data.ConnectionState.Open))
                        {
                            Console.WriteLine("Reconnecting DB");
                            pgsql = OpenDbConnection("Server=db;Username=postgres;Password=postgres;");
                        }
                        else
                        { // Normal +1 vote requested
                            UpdateVote(pgsql, vote.voter_id, vote.vote);
                        }
                    }
                    else
                    {
                        keepAliveCommand.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine(ex.ToString());
                return 1;
            }
        }

        private static NpgsqlConnection OpenDbConnection(string connectionString)
        {
            NpgsqlConnection connection;

            while (true)
            {
                try
                {
                    connection = new NpgsqlConnection(connectionString);
                    connection.Open();
                    break;
                }
                catch (SocketException)
                {
                    Console.Error.WriteLine("Waiting for db");
                    Thread.Sleep(1000);
                }
                catch (DbException)
                {
                    Console.Error.WriteLine("Waiting for db");
                    Thread.Sleep(1000);
                }
            }

            Console.Error.WriteLine("Connected to db");

            var command = connection.CreateCommand();
            command.CommandText = @"CREATE TABLE IF NOT EXISTS votes (
                                        id VARCHAR(255) NOT NULL UNIQUE,
                                        vote VARCHAR(255) NOT NULL
                                    )";
            command.ExecuteNonQuery();

            return connection;
        }

        private static ConnectionMultiplexer OpenRedisConnection(string hostname)
        {
            // Use IP address to workaround https://github.com/StackExchange/StackExchange.Redis/issues/410
            var ipAddress = GetIp(hostname);
            Console.WriteLine($"Found redis at {ipAddress}");

            while (true)
            {
                try
                {
                    Console.Error.WriteLine("Connecting to redis");
                    return ConnectionMultiplexer.Connect(ipAddress);
                }
                catch (RedisConnectionException)
                {
                    Console.Error.WriteLine("Waiting for redis");
                    Thread.Sleep(1000);
                }
            }
        }

        private static string GetIp(string hostname)
            => Dns.GetHostEntryAsync(hostname)
                .Result
                .AddressList
                .First(a => a.AddressFamily == AddressFamily.InterNetwork)
                .ToString();

        private static void UpdateVote(NpgsqlConnection connection, string voterId, string vote)
        {
            var command = connection.CreateCommand();
            try
            {
                command.CommandText = "INSERT INTO votes (id, vote) VALUES (@id, @vote)";
                command.Parameters.AddWithValue("@id", voterId);
                command.Parameters.AddWithValue("@vote", vote);
                command.ExecuteNonQuery();
            }
            catch (DbException)
            {
                command.CommandText = "UPDATE votes SET vote = @vote WHERE id = @id";
                command.ExecuteNonQuery();
            }
            finally
            {
                command.Dispose();
            }
        }
    }
}
~~~

#worker_cs_project

~~~cs
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net7.0</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="StackExchange.Redis" Version="2.2.4" />
    <PackageReference Include="Npgsql" Version="4.1.9" />
    <PackageReference Include="Newtonsoft.Json" Version="13.0.1" />
  </ItemGroup>

</Project>
~~~