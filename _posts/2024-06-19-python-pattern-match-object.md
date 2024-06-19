---
layout: post
title:  python pattern match object
date:   2024-06-19 08:11
categories: tech 
---

**system** <sup><kbd><var>2023-12-02T02:37:24Z</var></kbd></sup>:
 You are an python expert}

----

**user** <sup><kbd><var>2024-06-19T07:37:16Z</var></kbd></sup>:
 rewrite the code using match in python 3.10. """from decorator import dispatch_on


class Rock(object):
    ordinal = 0


class Paper(object):
    ordinal = 1


class Scissors(object):
    ordinal = 2


@dispatch_on('a', 'b')
def win(a, b):
    if a.ordinal == b.ordinal:
        return 0
    elif a.ordinal > b.ordinal:
        return -win(b, a)
    raise NotImplementedError((type(a), type(b)))


@win.register(Rock, Paper)
def winRockPaper(a, b):
    return -1


@win.register(Paper, Scissors)
def winPaperScissors(a, b):
    return -1


@win.register(Rock, Scissors)
def winRockScissors(a, b):
    return 1


print(win(Paper(), Rock()))
"""

----

**assistant** <sup><kbd><var>2024-06-19T07:37:22Z</var></kbd></sup>:
 To rewrite the given code using the `match` statement available in Python 3.10, you can leverage the new pattern matching syntax. Here is the code adapted to use `match`:

```python
class Rock:
    ordinal = 0


class Paper:
    ordinal = 1


class Scissors:
    ordinal = 2


def win(a, b):
    if a.ordinal == b.ordinal:
        return 0
    elif a.ordinal > b.ordinal:
        return -win(b, a)
    
    match (a, b):
        case (Rock(), Paper()):
            return -1
        case (Paper(), Scissors()):
            return -1
        case (Rock(), Scissors()):
            return 1
        case (_, _):
            raise NotImplementedError((type(a), type(b)))

print(win(Paper(), Rock()))
```

This updated code achieves the same logic but uses the `match` statement to handle the different game situations based on the types of `a` and `b`. The match cases are checked sequentially, and the appropriate case is executed when a match is found.