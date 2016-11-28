---
layout: post
title:  some useful bash 
date:   2015-06-09 23:03 
categories: tech 
---

### run a script for 10 times

```bash
for i in `seq 1 10`; do perl 81_rand_log_id.t ; done
```

### watch

```bash
### those is from man wacth
To watch for mail, you might do

              watch -n 60 from

To watch the contents of a directory change, you could use

              watch -d ls -l

If you're only interested in files owned by user joe, you might use

              watch -d 'ls -l | fgrep joe'


```
