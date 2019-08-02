[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!

# [linuxserver/quassel-web](https://github.com/linuxserver/docker-quassel-web)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/quassel-web.svg)](https://microbadger.com/images/linuxserver/quassel-web "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/quassel-web.svg)](https://microbadger.com/images/linuxserver/quassel-web "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/quassel-web.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/quassel-web.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-quassel-web/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-quassel-web/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/quassel-web/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/quassel-web/latest/index.html)

[Quassel-web](https://github.com/magne4000/quassel-webserver) is a web client for Quassel.  Note that a Quassel-Core instance is required, we have a container available [here.](https://hub.docker.com/r/linuxserver/quassel-core/) 


[![quassel-web](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/quassel-web-banner.png)](https://github.com/magne4000/quassel-webserver)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/quassel-web` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=quassel-web \
  -e PUID=1000 \
  -e PGID=1000 \
  -e QUASSEL_CORE=192.168.1.10 \
  -e QUASSEL_PORT=4242 \
  -e URL_BASE=/quassel `#optional` \
  -e NODE_ENV=production \
  -p 64080:64080 \
  -v <path to data>:/config \
  --restart unless-stopped \
  linuxserver/quassel-web
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  quassel-web:
    image: linuxserver/quassel-web
    container_name: quassel-web
    environment:
      - PUID=1000
      - PGID=1000
      - QUASSEL_CORE=192.168.1.10
      - QUASSEL_PORT=4242
      - URL_BASE=/quassel #optional
    volumes:
      - <path to data>:/config
    ports:
      - 64080:64080
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 64080` | will map the container's port 64080 to port 64080 on the host |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e QUASSEL_CORE=192.168.1.10` | specify the URL or IP address of your Quassel Core instance |
| `-e QUASSEL_PORT=4242` | specify the port of your Quassel Core instance |
| `-e URL_BASE=/quassel` | Specify a url-base in reverse proxy setups ie. `/quassel` |
| `-v /config` | this will store config on the docker host |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```


&nbsp;
## Application Setup

By default this container webui will be available on `http://$SERVER_IP:64080`. To setup this container you can either use the envrionment variables we recommend or manually setup the configuration file by leaving out the `QUASSEL_CORE` environment variable among others. 
The configuration file using this method can be found at:
```
/config/settings-user.js
```



## Support Info

* Shell access whilst the container is running: `docker exec -it quassel-web /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f quassel-web`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' quassel-web`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/quassel-web`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/quassel-web`
* Stop the running container: `docker stop quassel-web`
* Delete the container: `docker rm quassel-web`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start quassel-web`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull quassel-web`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d quassel-web`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once quassel-web
  ```

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using Docker Compose.

* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 
```
git clone https://github.com/linuxserver/docker-quassel-web.git
cd docker-quassel-web
docker build \
  --no-cache \
  --pull \
  -t linuxserver/quassel-web:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **28.06.19:** - Rebasing to alpine 3.10.
* **18.05.19:** - Reconfigure environmental variable setup.
* **28.04.19:** - Initial Release.
