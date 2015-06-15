# docker-nzbget

## Description

A Dockerfile for [NZBGet](http://nzbget.net/) version 15.0.

The default login is `nzbget` / `tegbzn6789`.

## Volumes

### `/config`
### `/downloads`


Configuration files and state for NzbGet.

## Ports

### 6789

WebUI port.

sudo docker run -i -p 6789:6789 -v /home/me/docker/config:/config:rw -v /home/me/docker/dl:/downloads:rw -t tocks/docker-nzbget
