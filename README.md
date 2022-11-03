# Docker Image for Open Source CPAP Analysis Reporter (OSCAR)

[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/rogerrum/docker-oscar)](https://hub.docker.com/r/rogerrum/docker-oscar/tags)
[![license](https://img.shields.io/github/license/rogerrum/docker-oscar)](https://github.com/rogerrum/docker-oscar/blob/main/LICENSE)
[![DockerHub pulls](https://img.shields.io/docker/pulls/rogerrum/docker-oscar.svg)](https://hub.docker.com/r/rogerrum/docker-oscar/)
[![DockerHub stars](https://img.shields.io/docker/stars/rogerrum/docker-oscar.svg)](https://hub.docker.com/r/rogerrum/docker-oscar/)
[![GitHub stars](https://img.shields.io/github/stars/rogerrum/docker-oscar.svg)](https://github.com/rogerrum/docker-oscar)
[![Contributors](https://img.shields.io/github/contributors/rogerrum/docker-oscar.svg)](https://github.com/rogerrum/docker-oscar/graphs/contributors)


A Docker image for OSCAR to run inside Docker container and access it remotely using web browser.

Repository name in Docker Hub: **[rogerrum/docker-oscar](https://hub.docker.com/r/rogerrum/docker-oscar/)**  
Published via **automated build** mechanism  

![img.png](https://raw.githubusercontent.com/rogerrum/docker-oscar/main/.github/demo-img.png)

## Docker Run
To simply do a quick and dirty run of the Oscar container:
```
docker run \
    -d --rm \
    --name oscar \
    -v=./oscar-data:/data \
    --publish=8080:8080 \
     rogerrum/docker-oscar
  
```
To stop the container simply run:
```
$ docker stop oscar
```
To remove the conainer simply run:
```
$ docker rm oscar
```

## Docker Compose
If you don't want to type out these long **Docker** commands, you could
optionally use [docker-compose](https://docs.docker.com/compose/) to set up your
image. Just download the repo and run it like so:

```yaml
version: '3.8'
services:
  oscar:
    image: rogerrum/docker-oscar:latest
    container_name: oscar
    restart: unless-stopped
    ports:
      - 8080:8080
    volumes:
      - ./oscar-data:/data:rw
```

## Issues:
https://github.com/rogerrum/docker-oscar/issues


Software Licensing Information
------------------------------
DOCKER-OSCAR is released under the GNU GPL v3 License. Please see below for a note on giving correct attribution
in redistribution of derivatives.

It is built using Qt SDK (Open Source Edition), available from http://qt.io.

Redistribution of derivatives ( a note added by Mark Watins )
-----------------------------
Mark Watkins created this software to help lessen the exploitation of others. Seeing his work being used to exploit others
is incredibly un-motivational, and incredibly disrespectful of all the work he put into this project.

If you plan on reselling any derivatives of SleepyHead, I specifically request that you give due credit and
link back, mentioning clearly in your advertising material, software installer and about screens that your
derivative "is based on the free and open-source software SleepyHead available from http://sleepyhead.jedimark.net,
developed and copyright by Mark Watkins (C) 2011-2018."

It is not enough to reference that your derivative "is based on GPL software".
