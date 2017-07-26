---
layout: post
title:  fun use of openssl 
date:   2017-07-26 09:10 
categories: tech 
---

## prime number test

```{bash}
➜  openssl prime 13
D is prime
➜  openssl prime 15
F is not prime
➜  openssl prime 1555555
17BC63 is not prime
```

## md5 and sha of file

```{bash}
➜  openssl md5 X.txt 
MD5(X.txt)= d681d678396d34aa67c83b79adf58a98
➜  openssl sha1 X.txt
SHA1(X.txt)= 01b2443494aaa77e13e6104278c1f5d045047b04
➜  openssl sha X.txt
SHA(X.txt)= efd44723f124a750dd35812450a819c869e2e84b
```

## rand number
```{bash}
➜  openssl rand -base64 15
z9amnSvmxdsW2GEvkqba
➜  openssl rand -base64 5
QeIhgug=
➜  openssl rand -base64 1
CA==
➜  openssl rand -base64 2
kEM=
➜  openssl rand -base64 6
Xv3CfWu0
➜  openssl rand -base64 2
EWA=
```

