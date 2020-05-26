---
layout: post
title:  docker mirrors in china 
date:   2020-05-26 15:37 
categories: tech 
---

## config the mirror

follow the instruction here:

http://mirrors.ustc.edu.cn/help/dockerhub.html

## usage

```
docker  pull apache/drill
```

will still use the official dockerhub repo

If you want to use the mirror, have to add mirror prefix

for example: to use apache/drill

```
docker pull hub-mirror.c.163.com/apache/drill
```

