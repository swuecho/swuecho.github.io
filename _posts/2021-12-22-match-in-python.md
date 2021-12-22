---
layout: post
title:  match in python 
date:   2021-12-22 14:03 
categories: tech
---
## replace basic if

```python
def factorial(n):
    """ try match"""
    match n:
        case 0:
            return 1
        case x:
            return x * factorial(x-1)

def factorial2(n):
    """ try match"""
    match n:
        case 0:
            return 1
        case _ as x:
            return x * factorial(x-1)

print(factorial(5))

print(factorial2(5))
```

```

```

```

```
