---
layout: post
title:  candy tutorial 
date:   2024-04-26 22:29 
categories: tech 
---

## 快速入门

常见的需求是, Server W 在公网, Server N在内网, 如何从W 访问 N?

W当server, N当client. 因为只有client 直接才能互相访问, 所以W并不能访问N, 需要在 W上也起一个client.

配置如下:

N client:
```
# 以客户端模式工作
mode = "client"
# 示例以 ws 传输明文,客户端支持 wss 协议
websocket = "ws://$w_public_ip:$port"
# 需要与服务端配置保持一致
password = "$your_pass"
tun = "172.16.0.12/16"
# 网卡名,区分单个机器上的多个客户端,同一台主机的网卡名不能冲突,不配置此项表示使用默认网卡名 candy
name = "candy"
```

W server:

```
# 以server模式工作
mode = "server"
# 示例以 ws 传输明文,客户端支持 wss 协议
websocket = "ws://0.0.0.0:8087"
# 需要与服务端配置保持一致
password = "$your_pass"

```

W client:
```
# 以客户端模式工作
mode = "client"
# 示例以 ws 传输明文,客户端支持 wss 协议
websocket = "ws://$w_public_ip:$port"
# 需要与服务端配置保持一致
password = "$your_pass"
tun = "172.16.0.13/16" # !!! 注意IP 与N client 不能一样.
# 网卡名,区分单个机器上的多个客户端,同一台主机的网卡名不能冲突,不配置此项表示使用默认网卡名 candy
name = "candy"
```

如果是用docker compose:
```
# docker-compose.yaml
version: '3'
services:
  candy:
    image: docker.io/lanthora/candy:latest
    privileged: true
    network_mode: host
    restart:
            always
    volumes:
      - /var/lib/candy:/var/lib/candy
      - ./conf/candy.conf:/etc/candy.conf
```
```

目录结构:
.
├── conf
│   └── candy.conf
└── docker-compose.yml

```


