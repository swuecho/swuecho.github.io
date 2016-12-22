---
layout: post
title:  chez scheme play 
date:   2016-12-20 13:28 
categories: tech 
---

# run a command line script

copy the sample script from user manual

```scheme
#! /usr/bin/scheme-script 
(import (rnrs))
(let ([args (cdr (command-line))])
  (unless (null? args)
    (let-values ([(newline? args)
                  (if (equal? (car args) "-n")
                      (values #f (cdr args))
                      (values #t args))])
      (do ([args args (cdr args)] [sep "" " "])
          ((null? args))
        (display sep)
        (display (car args)))
      (when newline? (newline)))))

```
run it

```bash
  chez git:(master)  ./echo_script.ss test_echo
  test_echo
```
compile version.


```bash
chez git:(master) echo '(compile-program "echo_script.ss")' | scheme
Chez Scheme Version 9.4.1
Copyright 1984-2016 Cisco Systems, Inc.

> compiling echo_script.ss with output to echo_script.so
()
>
chez git:(master) ./echo_script.so echo
echo

```
have to say it is damn hard to use.

why do not anyone come up with a solution to make comple the simple program easy.

Even the compile is done within scheme.

also, the speeed is not good.(both the interpreted and compiled version)


