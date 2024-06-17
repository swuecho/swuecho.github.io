---
layout: post
title:  qrun notes
date:   2024-06-17 07:27
categories: tech 
---


## check experiments using mlflow UI

internally `qrun` use mlflow, so mlflow tools can be used to check the runs.

```sh
mlflow ui --port=5005 --host=0.0.0.0
```