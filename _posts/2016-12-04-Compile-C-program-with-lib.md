---
layout: post
title:  Compile C program with lib 
date:   2016-12-04 13:52 
categories: tech 
---

```c
#include "apop.h"
#include "stdio.h"
int
main (void)
{
      int i;
      gsl_vector * v = gsl_vector_alloc (3);
          
      for (i = 0; i < 3; i++)
      {
        gsl_vector_set (v, i, 1.23 + i);
      }
      float sum = apop_vector_sum(v);
      printf("%f\n", sum);
      gsl_vector_free (v);
      return 0;
}
```


```bash
➜  c git:(master) ✗ gcc -L/usr/local/lib -lapophenia -lgsl -lgslcblas -lm  -o sum sum.c
/tmp/ccHBa8Gw.o: In function `main':
sum.c:(.text+0xe): undefined reference to `gsl_vector_alloc'
sum.c:(.text+0x45): undefined reference to `gsl_vector_set'
sum.c:(.text+0x5b): undefined reference to `apop_vector_sum'
sum.c:(.text+0x7e): undefined reference to `gsl_vector_free'
collect2: error: ld returned 1 exit status
➜  c git:(master) ✗ 
```

## what is the problem?

This works.

```bash
gcc sum.c -o sum `pkg-config --libs apophenia gsl` 
```

what is the fuck?


