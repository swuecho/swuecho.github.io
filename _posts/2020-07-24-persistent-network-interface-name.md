---
layout: post
title:  persistent network interface name in pve (or other distro)
date:   2020-07-24 12:52 
categories: tech 
---
## Problem

After install an extra nvme ssd, lost connection to the pve box. (the netwok led do not blink).

`ip link` command will display the network link names similar to below:
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp8s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master vmbr0 state UP mode DEFAULT group default qlen 1000
    link/ether a8:a1:59:07:39:22 brd ff:ff:ff:ff:ff:ff
```

The name is inconsistent with the `iface` name in`/etc/network/interfaces`. 

## solution

create as `system.link` file `/etc/systemd/network/70-enp9s0.link` with content:
```
[Match]
MACAddress=a8:a1:59:07:39:22

[Link]
Name=enp9s0
```
so every reboot end up with the network name `enp9s0` .

[https://unix.stackexchange.com/questions/504827/predictable-network-interface-device-names-change-with-new-ssd](https://unix.stackexchange.com/questions/504827/predictable-network-interface-device-names-change-with-new-ssd)
