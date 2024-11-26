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

### Architecture

![wordsmith](/assets/img/blog/wordsmith.png)

### Build and run in Docker Compose

The only requirement to build and run the app from source is Docker. Clone this repo and use Docker Compose to build all the images. You can use the new V2 Compose with docker compose or the classic docker-compose CLI:

~~~console
docker compose up --build
~~~

Or you can pull pre-built images from Docker Hub using docker compose pull.

#### docker-compose.yml

~~~yml
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

#### wordsmith/api/Dockerfile

~~~yml
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

#### wordsmith/web/Dockerfile


~~~yml
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

---

### Deploy using Kubernetes manifests

You can deploy the same app to Kubernetes using the [Kustomize configuration](#kustomization.yaml). It will define all of the necessary Deployment and Service objects and a ConfigMap to provide the database schema.

Apply the manifest using kubectl while at the root of the project:



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

#word.sql

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