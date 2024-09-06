---
layout: post
title:  ShellCrash 配置
date:   2024-09-06 11:15
categories: tech 
---


## shellcrash 配置

准备配置文件config.yaml

1. 下载subconvert

2. 在另一台局域网的机器上去访问subconvert, http://ip:25500 (保证可以在线导入config)

3. 如果不能访问, 看看是否是局域网的问题.
   
4. 拿到vmess 地址, 做url encode,
    
5. 替换 [https://sub.id9.cc/sub?target=clash&new](https://sub.id9.cc/sub?target=clash&new) _name=true&url=vmess&insert=false&config=https%3A%2F%2Fraw.githubusercontent.com%2FACL4SSR%2FACL4SSR%2Fmaster%2FClash%2Fconfig%2FACL4SSR_Online.ini 中的vmess, host 替换成本地http://192.X.X.X:255000

登录路由器后台, 进入 crash 选择在线导入配置文件.