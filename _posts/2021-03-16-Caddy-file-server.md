---
layout: post
title: Caddy File Server in Minutes
date:   2021-03-16 10:24 
categories: tech 
---

## directory structure
    Caddyfile  config  data  docker-compose.yml  site

## Caddy file

```
:80
root * /srv/
file_server browse
```

##  docker-compose

```
version: "3.7"

services:
  caddy:
    image: caddy:2.3.0
    restart: unless-stopped
    ports:
      - "8081:80"
    volumes:
      - $PWD/Caddyfile:/etc/caddy/Caddyfile
      - ./site:/srv
      - ./data:/data
      - ./config:/config
```
