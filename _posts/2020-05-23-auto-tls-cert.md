---
layout: post
title:  auto tls cert 
date:   2020-05-23 18:50 
categories: tech 
---

## install acme.sh

```
curl https://get.acme.sh | sh
# more info https://github.com/acmesh-official/acme.sh

```

## issue cert, use dnsapi (Automatic DNS API integration)

I am using digital ocean's dns service, so follow.
https://github.com/acmesh-official/acme.sh/wiki/dnsapi#20-use-digitalocean-api-native


```
export DO_API_KEY="75310dc4ca779ac39a19f6355db573b49ce92ae126553ebd61ac3a3ae34834cc"
Ok, let's issue a cert now:

acme.sh --issue --dns dns_dgon -d example.com -d *.example.com
```
the cert will generated and check the output for cert location


## but my domain name provider does not have api.

1. try dns-alis mode ( I tried, but fail)
2. change the ns record in your domain name provider to the dns service which has api support (such as digital ocean)





