---
layout: post
title:  pass parameter to docker
date:   2023-09-14 14:55
categories: tech
---

Dockfile
```Dockfile
FROM python:3.10
WORKDIR /app
COPY . .

# https://stackoverflow.com/questions/32727594/how-to-pass-arguments-to-shell-script-through-docker-run
#ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
#ENTRYPOINT  ["sh", "-c", "/app/entrypoint.sh \"$@\"", "--"]
CMD ["sh", "-c", "/app/entrypoint.sh \"$@\"", "--"]
```

```sh
#!bin/bash
echo $@
```

Both the line starting with `ENTRYPOINT` is correct. The line starting with `CMD` is wrong. The answer is in https://stackoverflow.com/questions/32727594/how-to-pass-arguments-to-shell-script-through-docker-run 


`docker run your_image arg1 arg2` will replace the value of CMD with `arg1 arg2`. That's a full replacement of the CMD, not appending more values to it. This is why you often see `docker run some_image /bin/bash` to run a bash shell in the container.