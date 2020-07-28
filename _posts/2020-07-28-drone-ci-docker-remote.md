---
layout: post
title:  drone ci docker remote 
date:   2020-07-28 16:14 
categories: tech 
---

When use drone exec runner, there are two options. 

1. run and install as root
2. run and install as regular user.

There are no document about how to install and run as regular user. Anyone could figure out by himself/herself, if you had enough time.

However, run as root user have a problem when docker-compose run on remote machine using ssh. 
For root user, the home dir is /root. the priviate key should be in /root/.ssh/id_rsa. After settting this up, in drone runner machine, ssh into target machine have no problem. For unknown reason, docker-compose will throw errors. 

```
\[16183\] Failed to execute script docker-compose

/tmp/_MEIC48NdP/paramiko/client.py:837: UserWarning: Unknown ssh-ed25519 host key for hostname: b'f3ce2a323529fc55d2acd79b28cc2569'

Traceback (most recent call last):
File "bin/docker-compose", line 6, in &lt;module&gt;
File "compose/cli/main.py", line 72, in main
File "compose/cli/main.py", line 125, in perform_command
File "compose/cli/command.py", line 76, in project\_from\_options
File "compose/cli/command.py", line 142, in get_project
File "compose/cli/docker_client.py", line 47, in get_client
File "compose/cli/docker_client.py", line 169, in docker_client
File "site-packages/docker/api/client.py", line 166, in \_\_init\_\_
File "site-packages/docker/transport/sshconn.py", line 111, in \_\_init\_\_
File "site-packages/docker/transport/sshconn.py", line 119, in _connect
File "site-packages/paramiko/client.py", line 446, in connect
File "site-packages/paramiko/client.py", line 765, in _auth
paramiko.ssh_exception.SSHException: No authentication methods available

```



Ater hitting the wall, I figure out a way out.

1. copy the docker-compose.yml file to a /tmp directory
2. swich user to regluar user and run docker-compose in a script.


```
# make a dir and copy docker-compose and bash script there
mkdir -p /tmp/some_dir
cp update_image_remote.sh /tmp/some_dir/update_image_remote.sh 
cp docker-compose.yml /tmp/some_dir/docker-compose.yml 
# run as regular user
/bin/su -c "/bin/bash /tmp/some_dir/update_image_remote.sh" - regular_user
```

