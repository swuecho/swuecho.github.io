---
layout: post
title:  k0s replace gcr images 
date:   2022-07-13 07:12 
categories: tech 
---

<pre>
<code>ubuntu@VM-0-6-ubuntu:~$ sudo k0s ctr image
NAME:
ctr images - manage images
USAGE:
ctr images command [command options] [arguments...]
COMMANDS:
check       check that an image has all content available locally
export      export images
import      import images
list, ls    list images known to containerd
mount       mount an image to a target path
unmount     unmount the image from the target
pull        pull an image from a remote
push        push an image to a remote
remove, rm  remove one or more images by reference
tag         tag an image
label       set and clear labels for an image
OPTIONS:
--help, -h  show help</code>
</pre>
<p>
</p>
<p>In some country, it is disgusting that gcr is blocked. 
</p>
<p>
</p>
<p>If you are using k0s, the infra pod pull will fail. 
</p>
<p>
</p>
<p>The easiest solution is pull the image from other registry and retag it with the gcr name (cheating the k0s)
</p>
<p>
</p>
<pre>
<code>#!/bin/sh
for name in kube-controller-manager:v1.18.3 kube-scheduler:v1.18.3 kube-proxy:v1.18.3 pause:3.2 etcd:3.4.3-0 coredns:1.6.7 kube-apiserver:v1.18.3
do
sudo k0s ctr image pull registry.cn-hangzhou.aliyuncs.com/google_containers/$name
sudo k0s ctr image tag registry.cn-hangzhou.aliyuncs.com/google_containers/$name k8s.gcr.io/$name
sudo k0s ctr image rmi registry.cn-hangzhou.aliyuncs.com/google_containers/$name
done</code>
</pre>
<p>
</p>

