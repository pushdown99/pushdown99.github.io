---
layout: post
title: 'Kubernetes Exmaple App: Wordsmith' 
author: haeyeon.hwang
tags: [Kubernetes, k8s]
description: >
  쿠버네티스 샘플 구성: Wordsmith 
image: /assets/img/blog/wordsmith.png
hide_image: true
---

## Kubernetes Sample Code: Word Smith

### Source Code

~~~console
git clone https://github.com/dockersamples/wordsmith.git
cd wordsmith
~~~

The demo app runs across three containers:

컨테이너|설명
---|---
api|a Java REST API which serves words read from the database
web|a Go web application that calls the API and builds words into sentences
db|a Postgres database that stores words

~~~console
tree

├─api
│  └─src
│      └─main
│          └─java
├─db
├─k8s-manifests
└─web
    └─static
        ├─fonts
        └─images
~~~

#### api

- [api/pom.xml](#pom.xml)
- [api/Dockerfile](#api_Dockerfile)
- [api/src/main/java.main.java](#main.java)

#### web

- [web/dispatcher.go](#dispatcher.go)
- [web/Dockerfile](#web_Dockerfile)
- [web/static/index.html](#index.html)
- [web/static/app.js](#app.js)

#### db

- [db/words.sql](#words.sql)

#### k8s-manifests

- [k8s-manifests/api.yaml](#manifest_api.yaml)
- [k8s-manifests/db.yaml](#manifest_db.yaml)
- [k8s-manifests/web.yaml](#manifest_web.yaml)

### Architecture

![wordsmith](/assets/img/blog/wordsmith.png)

### Build and run in Docker Compose

The only requirement to build and run the app from source is Docker. Clone this repo and use Docker Compose to build all the images. You can use the new V2 Compose with docker compose or the classic docker-compose CLI:

~~~console
docker compose up --build
~~~

Or you can pull pre-built images from Docker Hub using docker compose pull.

#### docker-compose.yml

~~~yaml
version: '3.9'
# we'll keep the version for now to work in Compose and Swarm

services:
  db:
    image: postgres:10.0-alpine
    volumes:
      - ./db:/docker-entrypoint-initdb.d/

  api:
    build: api
    image: dockersamples/wordsmith-api
    deploy:
      replicas: 5

  web:
    build: web
    image: dockersamples/wordsmith-web
    ports:
     - "8080:80"
~~~


---

### Deploy using Kubernetes manifests

You can deploy the same app to Kubernetes using the [Kustomize configuration](#kustomization.yaml). It will define all of the necessary Deployment and Service objects and a ConfigMap to provide the database schema.

Apply the manifest using kubectl while at the root of the project:

### Connect to pod

~~~console
kubectl get pods

NAME                                     READY   STATUS    RESTARTS       AGE
api-7849895d7-8kpc8                      1/1     Running   0              164m
api-7849895d7-cwvv6                      1/1     Running   0              164m
api-7849895d7-fl4bz                      1/1     Running   0              164m
api-7849895d7-r87gq                      1/1     Running   0              164m
api-7849895d7-trzr9                      1/1     Running   0              164m
coredns-7db6d8ff4d-jkpv6                 1/1     Running   7 (21h ago)    14d
coredns-7db6d8ff4d-q2gf7                 1/1     Running   7 (21h ago)    14d
db-545b8b4744-jmb6w                      1/1     Running   0              164m
etcd-docker-desktop                      1/1     Running   7 (21h ago)    14d
kube-apiserver-docker-desktop            1/1     Running   7 (21h ago)    14d
kube-controller-manager-docker-desktop   1/1     Running   7 (21h ago)    14d
kube-proxy-8cssg                         1/1     Running   7 (21h ago)    14d
kube-scheduler-docker-desktop            1/1     Running   18 (21h ago)   14d
storage-provisioner                      1/1     Running   24 (21h ago)   14d
vpnkit-controller                        1/1     Running   8 (21h ago)    14d
web-6f4cc769f-hwjkm                      1/1     Running   0              164m
~~~

~~~console
kubectl exec api-7849895d7-8kpc8 -it -- bash

bash-4.2#
~~~

### logs 
~~~console
kubectl logs -f deployment/api

Found 5 pods, using pod/api-7849895d7-r87gq
{"word":"pushes"}
{"word":"møby døck"}
{"word":"flødebolle"}
{"word":"løves"}
{"word":"viking"}
{"word":"will ship"}
{"word":"the serverless"}
{"word":"an awesøme"}
{"word":"laptøp"}
{"word":"will drink"}
{"word":"a pink"}
{"word":"walks tøwards"}
{"word":"flødebolle"}
{"word":"a pink"}
{"word":"smørrebrød"}
{"word":"the impressive"}
{"word":"cøntainer"}
{"word":"the impressive"}
{"word":"helps"}
~~~

~~~console
kubectl logs -f deployment/web

2024/11/26 04:49:24 /noun 5 available ips: [10.1.0.114 10.1.0.115 10.1.0.112 10.1.0.113 10.1.0.111]
2024/11/26 04:49:24 /adjective 5 available ips: [10.1.0.112 10.1.0.111 10.1.0.113 10.1.0.115 10.1.0.114]
2024/11/26 04:49:24 /noun I choose 10.1.0.115
2024/11/26 04:49:24 /noun Calling http://10.1.0.115:8080/noun
2024/11/26 04:49:24 /adjective I choose 10.1.0.115
2024/11/26 04:49:24 /adjective Calling http://10.1.0.115:8080/adjective
2024/11/26 04:49:24 /adjective 5 available ips: [10.1.0.115 10.1.0.113 10.1.0.111 10.1.0.114 10.1.0.112]
2024/11/26 04:49:24 /noun 5 available ips: [10.1.0.115 10.1.0.114 10.1.0.112 10.1.0.111 10.1.0.113]
2024/11/26 04:49:24 /adjective I choose 10.1.0.115
2024/11/26 04:49:24 /noun I choose 10.1.0.113
2024/11/26 04:49:24 /adjective Calling http://10.1.0.115:8080/adjective
2024/11/26 04:49:24 /noun Calling http://10.1.0.113:8080/noun
2024/11/26 04:49:24 /verb 5 available ips: [10.1.0.114 10.1.0.113 10.1.0.112 10.1.0.111 10.1.0.115]
2024/11/26 04:49:24 /verb I choose 10.1.0.115
2024/11/26 04:49:24 /verb Calling http://10.1.0.115:8080/verb
~~~

---

#kustomization.yaml

~~~yml
resources:
  - k8s-manifests/api.yaml
  - k8s-manifests/db.yaml
  - k8s-manifests/web.yaml
configMapGenerator:
  - name: db-schema
    files:
      - ./db/words.sql
generatorOptions:
  disableNameSuffixHash: true
~~~

#api.yaml

~~~yml
apiVersion: v1
kind: Service
metadata:
  name: api
  labels:
    app: api
spec:
  ports:
    - port: 8080
      targetPort: 8080
      name: api
  selector:
    app: api
  clusterIP: None
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
  labels:
    app: api
spec:
  replicas: 5
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: api
          image: dockersamples/wordsmith-api
          ports:
            - containerPort: 8080
              name: api
~~~

#db.yaml

~~~yaml
apiVersion: v1
kind: Service
metadata:
  name: db
  labels:
    app: db
spec:
  ports:
    - port: 5432
      targetPort: 5432
      name: db
  selector:
    app: db
  clusterIP: None
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: db
  labels:
    app: db
spec:
  selector:
    matchLabels:
      app: db
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: postgres:10.0-alpine
          ports:
            - containerPort: 5432
              name: db
          volumeMounts:
            - name: db-schema
              mountPath: /docker-entrypoint-initdb.d
      volumes:
        - name: db-schema
          configMap:
            name: db-schema
~~~

#web.yaml

~~~yml
apiVersion: v1
kind: Service
metadata:
  name: db
  labels:
    app: db
spec:
  ports:
    - port: 5432
      targetPort: 5432
      name: db
  selector:
    app: db
  clusterIP: None
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: db
  labels:
    app: db
spec:
  selector:
    matchLabels:
      app: db
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: postgres:10.0-alpine
          ports:
            - containerPort: 5432
              name: db
          volumeMounts:
            - name: db-schema
              mountPath: /docker-entrypoint-initdb.d
      volumes:
        - name: db-schema
          configMap:
            name: db-schema
~~~


#main.java

~~~java
import com.google.common.base.Charsets;
import com.google.common.base.Supplier;
import com.google.common.base.Suppliers;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.sql.*;
import java.util.NoSuchElementException;

public class Main {
    public static void main(String[] args) throws Exception {
        Class.forName("org.postgresql.Driver");

        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);
        server.createContext("/noun", handler(() -> randomWord("nouns")));
        server.createContext("/verb", handler(() -> randomWord("verbs")));
        server.createContext("/adjective", handler(() -> randomWord("adjectives")));
        server.start();
    }

    private static String randomWord(String table) {
        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://db:5432/postgres", "postgres", "")) {
            try (Statement statement = connection.createStatement()) {
                try (ResultSet set = statement.executeQuery("SELECT word FROM " + table + " ORDER BY random() LIMIT 1")) {
                    while (set.next()) {
                        return set.getString(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        throw new NoSuchElementException(table);
    }

    private static HttpHandler handler(Supplier<String> word) {
        return t -> {
            String response = "{\"word\":\"" + word.get() + "\"}";
            byte[] bytes = response.getBytes(Charsets.UTF_8);

            System.out.println(response);
            
            t.getResponseHeaders().add("content-type", "application/json; charset=utf-8");
            t.getResponseHeaders().add("cache-control", "private, no-cache, no-store, must-revalidate, max-age=0");
            t.getResponseHeaders().add("pragma", "no-cache");

            t.sendResponseHeaders(200, bytes.length);

            try (OutputStream os = t.getResponseBody()) {
                os.write(bytes);
            }
        };
    }
}
~~~

#pom.xml

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>codestory</groupId>
    <artifactId>words</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>

    <build>
        <finalName>words</finalName>

        <pluginManagement>
            <plugins>
                <plugin>
                    <artifactId>maven-clean-plugin</artifactId>
                    <version>3.2.0</version>
                </plugin>
                <plugin>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>3.10.1</version>
                </plugin>
                <plugin>
                    <artifactId>maven-deploy-plugin</artifactId>
                    <version>3.0.0</version>
                </plugin>
                <plugin>
                    <artifactId>maven-install-plugin</artifactId>
                    <version>3.1.0</version>
                </plugin>
                <plugin>
                    <artifactId>maven-resources-plugin</artifactId>
                    <version>3.3.0</version>
                </plugin>
                <plugin>
                    <artifactId>maven-surefire-plugin</artifactId>
                    <version>2.19.1</version>
                </plugin>
            </plugins>
        </pluginManagement>

        <plugins>
            <plugin>
                <artifactId>maven-dependency-plugin</artifactId>
                <version>3.4.0</version>
                <executions>
                    <execution>
                        <id>copy-dependencies</id>
                        <phase>package</phase>
                        <goals>
                            <goal>copy-dependencies</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.3.0</version>
                <configuration>
                    <archive>
                        <manifest>
                            <addClasspath>true</addClasspath>
                            <classpathPrefix>dependency</classpathPrefix>
                            <mainClass>Main</mainClass>
                        </manifest>
                    </archive>
                </configuration>
            </plugin>
        </plugins>
    </build>

    <dependencies>
        <dependency>
            <groupId>com.google.guava</groupId>
            <artifactId>guava</artifactId>
            <version>32.0.1-jre</version>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
            <version>42.7.2</version>
        </dependency>
    </dependencies>
</project>
~~~

#api_Dockerfile

~~~yaml
# Build stage
FROM --platform=${BUILDPLATFORM} maven:3-amazoncorretto-20 as build
WORKDIR /usr/local/app
COPY pom.xml .
RUN mvn verify -DskipTests --fail-never
COPY src ./src
RUN mvn verify

# Run stage
FROM --platform=${TARGETPLATFORM} amazoncorretto:20
WORKDIR /usr/local/app
COPY --from=build /usr/local/app/target .
ENTRYPOINT ["java", "-Xmx8m", "-Xms8m", "-jar", "/usr/local/app/words.jar"]
EXPOSE 8080
~~~

#dispatcher.go

~~~go
package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"math/rand"
	"net"
	"net/http"
	"time"
)

func main() {
	rand.Seed(time.Now().UnixNano())

	fwd := &forwarder{"api", 8080}
	http.Handle("/words/", http.StripPrefix("/words", fwd))
	http.Handle("/", http.FileServer(http.Dir("static")))

	fmt.Println("Listening on port 80")
	http.ListenAndServe(":80", nil)
}

type forwarder struct {
	host string
	port int
}

func (f *forwarder) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	addrs, err := net.LookupHost(f.host)
	if err != nil {
		log.Println("Error", err)
		http.Error(w, err.Error(), 500)
		return
	}

	log.Printf("%s %d available ips: %v", r.URL.Path, len(addrs), addrs)
	ip := addrs[rand.Intn(len(addrs))]
	log.Printf("%s I choose %s", r.URL.Path, ip)

	url := fmt.Sprintf("http://%s:%d%s", ip, f.port, r.URL.Path)
	log.Printf("%s Calling %s", r.URL.Path, url)

	if err = copy(url, ip, w); err != nil {
		log.Println("Error", err)
		http.Error(w, err.Error(), 500)
		return
	}
}

func copy(url, ip string, w http.ResponseWriter) error {
	resp, err := http.Get(url)
	if err != nil {
		return err
	}

	for header, values := range resp.Header {
		for _, value := range values {
			w.Header().Add(header, value)
		}
	}
	w.Header().Set("source", ip)

	buf, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return err
	}

	_, err = w.Write(buf)
	return err
}
~~~

#web_Dockerfile

~~~yaml
# BUILD
# use the build platforms matching arch rather than target arch
FROM --platform=$BUILDPLATFORM golang:alpine as builder
WORKDIR /usr/local/app
ARG TARGETARCH

COPY dispatcher.go .

# build for the target arch not the build platform host arch
RUN GOOS=linux GOARCH=$TARGETARCH go build dispatcher.go

# RUN
# defaults to using the target arch image
FROM alpine:latest
WORKDIR /usr/local/app

COPY --from=builder /usr/local/app/dispatcher ./
COPY static ./static/

EXPOSE 80
CMD ["/usr/local/app/dispatcher"]
~~~

#index.html

~~~html
<!DOCTYPE html>
<html lang="en" ng-app="lab">
<head>
  <meta charset="utf-8">
  <title>dockercon EU 18</title>
  <link rel="stylesheet" href="style.css">
</head>

<body>
  <div class="logo"><img src="images/logo.svg" style="width:50%"/></div>

<div class="sentence" ng-controller="LabCtrl">
  <div class="line line1 slide-in">
  <span class="result adjective slide-in">
    <span class="word slide-in" ng-bind="adjective1.word"></span>
    <span class="hostname" ng-bind="adjective1.hostname"></span>
  </span>
  <span class="result noun slide-in">
    <span class="word" ng-bind="noun1.word"></span>
    <span class="hostname" ng-bind="noun1.hostname"></span>
  </span>
  </div>
  <div class="line line2 slide-in">
  <span class="result verb slide-in">
    <span class="word" ng-bind="verb.word"></span>
    <span class="hostname" ng-bind="verb.hostname"></span>
  </span>
  </div>
  <div class="line line3 slide-in">
  <span class="result adjective slide-in">
    <span class="word" ng-bind="adjective2.word"></span>
    <span class="hostname" ng-bind="adjective2.hostname"></span>
  </span>
  <span class="result noun slide-in">
    <span class="word" ng-bind="noun2.word"></span>
    <span class="hostname" ng-bind="noun2.hostname"></span>
  </span>
  </div>
</div>

<div class="footer"><img src="images/homes.png" /></div>
</body>

<script src="angular.min.js"></script>
<script src="app.js"></script>
</html>
~~~

#app.js

~~~javascript
"use strict";

var lab = angular.module('lab', []);

lab.controller('LabCtrl', function ($scope, $http, $timeout) {
  $scope.noun1 = "";
  $scope.noun2 = "";
  $scope.adjective1 = "";
  $scope.adjective2 = "";
  $scope.verb = "";

  getWord($http, $timeout, '/words/noun?n=1', function(resp1) {
    $scope.noun1 = word(resp1);
  });

  getWord($http, $timeout, '/words/adjective?a=1', function(resp) {
    var adj = word(resp);
    adj.word = adj.word.charAt(0).toUpperCase() + adj.word.substr(1)
    $scope.adjective1 = adj;
  });

  getWord($http, $timeout, '/words/verb', function(resp) {
    $scope.verb = word(resp);
  });

  getWord($http, $timeout, '/words/noun?n=2', function(resp2) {
    $scope.noun2 = word(resp2);
  });

  getWord($http, $timeout, '/words/adjective?n=2', function(resp) {
    $scope.adjective2 = word(resp);
  });
});

function getWord($http, $timeout, url, callback) {
  $http.get(url).then(callback, function(resp) {
    $timeout(function() {
      console.log("Retry: " + url);
      getWord($http, $timeout, url, callback);
    }, 500);
  });
}

function word(resp) {
  return {
    word: resp.data.word,
    hostname: resp.headers()["source"]
  };
}
~~~

#words.sql

Insert words to nouns, verbs, adjectives tables.

~~~sql
CREATE TABLE nouns (word TEXT NOT NULL);
CREATE TABLE verbs (word TEXT NOT NULL);
CREATE TABLE adjectives (word TEXT NOT NULL);

INSERT INTO nouns(word) VALUES
  ('cloud'),
  ('elephant'),
  ('gø language'),
  ('laptøp'),
  ('cøntainer'),
  ('micrø-service'),
  ('turtle'),
  ('whale'),
  ('gøpher'),
  ('møby døck'),
  ('server'),
  ('bicycle'),
  ('viking'),
  ('mermaid'),
  ('fjørd'),
  ('legø'),
  ('flødebolle'),
  ('smørrebrød');

INSERT INTO verbs(word) VALUES
  ('will drink'),
  ('smashes'),
  ('smøkes'),
  ('eats'),
  ('walks tøwards'),
  ('løves'),
  ('helps'),
  ('pushes'),
  ('debugs'),
  ('invites'),
  ('hides'),
  ('will ship');

INSERT INTO adjectives(word) VALUES
  ('the exquisite'),
  ('a pink'),
  ('the røtten'),
  ('a red'),
  ('the serverless'),
  ('a brøken'),
  ('a shiny'),
  ('the pretty'),
  ('the impressive'),
  ('an awesøme'),
  ('the famøus'),
  ('a gigantic'),
  ('the gløriøus'),
  ('the nørdic'),
  ('the welcøming'),
  ('the deliciøus');
~~~

#manifest_api.yaml

~~~yaml
apiVersion: v1
kind: Service
metadata:
  name: api
  labels:
    app: api
spec:
  ports:
    - port: 8080
      targetPort: 8080
      name: api
  selector:
    app: api
  clusterIP: None
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
  labels:
    app: api
spec:
  replicas: 5
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: api
          image: dockersamples/wordsmith-api
          ports:
            - containerPort: 8080
              name: api
~~~

#manifest_db.yaml

~~~yaml
apiVersion: v1
kind: Service
metadata:
  name: db
  labels:
    app: db
spec:
  ports:
    - port: 5432
      targetPort: 5432
      name: db
  selector:
    app: db
  clusterIP: None
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: db
  labels:
    app: db
spec:
  selector:
    matchLabels:
      app: db
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: postgres:10.0-alpine
          ports:
            - containerPort: 5432
              name: db
          volumeMounts:
            - name: db-schema
              mountPath: /docker-entrypoint-initdb.d
      volumes:
        - name: db-schema
          configMap:
            name: db-schema
~~~

#manifest_web.yaml

~~~yaml
apiVersion: v1
kind: Service
metadata:
  name: web
  labels:
    app: web
spec:
  ports:
    - port: 8080
      targetPort: 80
      name: web
  selector:
    app: web
  type: LoadBalancer
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  labels:
    app: web
spec:
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: web
          image: dockersamples/wordsmith-web
          ports:
            - containerPort: 80
              name: web
~~~