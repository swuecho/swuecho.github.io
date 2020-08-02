---
layout: post
title:  install and config devpi as local pypi cache 
date:   2020-08-02 15:18 
categories: tech 
---

## install and config devpi

1. install

```
pip install -U devpi-server
# if you want the web interface
pip install -U devpi-web
```

2. init

```
devpi-init  --serverdir ~/home/dev/devpi/mydevpiserver
```

3. gen config

```
cd  ~/home/dev/devpi
devpi-gen-config  --port 3141  --host=0.0.0.0  --serverdir ./mydevpiserver
```

4. systemd

```
cd gen-config
sudo cp devpi.service /etc/systemd/system
```

5. start service
```
sudo systemctl daemon-reload
sudo systemdctl start devp
```


##  Use the devpi

```
 pip3 install -i $PYPI --trusted-host=${TRUSTED_HOST}  uwsgi
```


