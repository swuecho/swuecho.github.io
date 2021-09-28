---
layout: post
title:  Exposing service of Kubernetes in bare metals
date:   2021-09-28 04:20 
categories: tech 
---

<h1>Exposing service of Kubernetes in bare metals.
</h1>
<p>
</p>
<p>If you tried k3s, k0s etc in bare metals, it is likely you find the ingress is a mess and find yourself lost. After endless search and tries, I think
</p>
<p>local proxy combined with nodePort is the easiest solution.
</p>
<p>
</p>
<p>    external traffic -&gt; proxy -&gt; nodePort 
</p>
<p>
</p>
<p>For the proxy part, nginx and envoy are both good choice. I use envoy because of I need grpc-web.
</p>
<p>
</p>
<p>Pro: 
</p>
<p>   1. do not have to config ingress, which is not mature enough at the moment.
</p>
<p>   2. if you are migrating from docker-compose or traditional deployment. Your only need to change the proxy address and port. (not learning
</p>
<p data-indent="1">ingress config). 
</p>
<p>   3. just work!
</p>
<p>
</p>
<p>Cons:
</p>
<p>   1. not everything in kubernetes. You either run the proxy as a service in VM or run the service in docker.
</p>
<p>   2. in kubernetes docs. NodePort is not recommended, because of port range limit, but with external proxy. it is not a problem.
</p>
<p>
</p>
<p>envoy cluster config:
</p>
<p>
</p>
<pre>
<code>clusters:
- name: app_service
connect_timeout: 20s
type: logical_dns
http2_protocol_options: {}
lb_policy: round_robin
load_assignment:
cluster_name:  app-server
endpoints:
- lb_endpoints:
- endpoint:
address:
socket_address:
address: IP_OF_NODE
port_value:  30009</code>
</pre>
<p>
</p>
<p>service template:
</p>
<p>
</p>
<pre>
<code>apiVersion: v1
kind: Service
metadata:
name: app-server
namespace: your-namespace
labels:
app: app-server
spec:
type: NodePort
ports:
- name: http
port: 9090
targetPort: 9090
nodePort: 30009
selector:
app: app-server
---
</code>
</pre>
<p>
</p>


