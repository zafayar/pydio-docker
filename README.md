# zafayar/pydio-docker

**This is work in progress and not ready for production use.  Feedback is welcome.**

This repository contains Docker file for Pydio 8, build using Docker's automated build system.

## Base Image
[phusion/baseimage:0.9.21](http://phusion.github.io/baseimage-docker/)

## Features and Dependenices

### Included
* Nginx as the web server, running on port 80
* Php7-fpm with require modules, including apcu
* Memcached installed with 256 MB memory allocation
* [Pydio Booster](https://pydio.com/en/pydio-booster), installed and running on port 8090

### Requires
* MySQL/MariaDB Server or Postgres SQL Server.  Can use SQLite, but not recommended outside of testing.
* Reverse proxy server with HTTPS. The docker contaniner run on HTTP only and it is recommended to use a reverse proxy for both Nginx and Pydio Booster.

## Usage
Download automated build from public Docker Hub Registry: 
```docker pull zafayar/pydio-docker```

Run using

```
	docker run 
		-rm 
		-name pydio 
		-e PGID=<Group id> 
		-e PUID=<User id> 
		-v <logfolder>:/log 
		-v <dataFolder>:/data 
		-p 50080:80 
		-p 8090:8090  
		zafayar/pydio-docker
```

## Parameters

* `-e PGID`	for for GroupID - see below for explanation
* `-e PUID`	for for UserID - see below for explanation
* `-v /log`	Path where all log files will be stored
* `-v /data`	Path where all config and personal drive is stored.  
* `-p 80`	The port of web interface.  **Not HTTPS**
* `-p 8090`	The port of pydio booster

You can also mount other folder to the docker to expose local data to the container.  

### User / Group Identifiers

Pydio being a file storage system, the data volumes (`-v` flags) can cause permissions issues between the host OS and the container. 
This is avoided by specifing the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will work.  Idea borrowed from [LinuxServer Dockers](https://hub.docker.com/u/linuxserver/).

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```




### To Do
* Allow environment variables to turn off MemcacheD and Pydio Booster if requires
* Seperate mount points for config and data
* Move to a smaller base image, maybe alpine based.

 
