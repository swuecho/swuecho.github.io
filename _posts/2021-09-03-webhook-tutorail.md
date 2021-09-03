---
layout: post
title:  webhook tutorial in ubuntu
date:   2021-09-03 21:33 
categories: tech 
---

## install webhook

`apt install webhook`

## config system.

check the config path using `sudo systemctl status webhook`

after install, change the default `ExecStart` as show below. 

### why

a. the the default `-hooks webhook.conf` does not tell the format is `json` or `yaml`.
(I tried to use webhook.yaml or webhook.yml, neither of them works.)

b. versbose to show the log, check the log using `sudo journalctl -u webhook -f`

```
[Unit]
Description=Small server for creating HTTP endpoints (hooks)
Documentation=https://github.com/adnanh/webhook/

[Service]
ExecStart=/usr/bin/webhook -nopanic -hotreload -verbose -hooks /home/hwu/dev/webhook/config/webhook.json 


[Install]
WantedBy=multi-user.target
```

## write your first webhook

### config:

```
[
  {
    "id": "simpleone",
    "execute-command": "/home/hwu/dev/webhook/config/commands/simple-one.sh",
    "command-working-directory": "/home/hwu/dev/webhook/",
    "response-message": "Executing simple webhook..."
  }
]
```

### comand:

```
app:~/dev/webhook$ cat config/commands/simple-one.sh
#!/bin/sh
touch `date --rfc-3339=date`.txt
```

make sure the dir and command path is valid. then go to 

```
http://your-host:9000/hooks/simpleone
```
and check the command run dir, see if correct file is touched.

## valid user input using trigger-rule

TODO: