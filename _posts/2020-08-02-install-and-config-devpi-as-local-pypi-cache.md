---
layout: post
title:  install and config devpi as local pypi cache 
date:   2020-08-02 15:18 
categories: tech 
---

## install and config devpi

1. install

    ```bash
    pip install -U devpi-server
    # if you want the web interface
    pip install -U devpi-web
    ```

2. init

    ```bash
    devpi-init  --serverdir ~/home/dev/devpi/mydevpiserver
    ```

3. gen config

    ```bash
    cd  ~/home/dev/devpi
    devpi-gen-config  --port 3141  --host=0.0.0.0  --serverdir ./mydevpiserver
    ```

4. systemd

    ```bash
    cd gen-config
    sudo cp devpi.service /etc/systemd/system
    ```

5. start service

    ```bash
    sudo systemctl daemon-reload
    sudo systemdctl start devp
    ```

## Use the devpi

```bash
pip3 install -i $PYPI --trusted-host=${TRUSTED_HOST}  uwsgi
```
