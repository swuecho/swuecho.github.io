---
layout: post
title:  toeplitz matrix in R 
date:   2017-01-07 18:53 
categories: tech 
---

suprisely, there is a function in R to create a toeplitz matrix

```r
> toeplitz(0:9)
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
 [1,]    0    1    2    3    4    5    6    7    8     9
 [2,]    1    0    1    2    3    4    5    6    7     8
 [3,]    2    1    0    1    2    3    4    5    6     7
 [4,]    3    2    1    0    1    2    3    4    5     6
 [5,]    4    3    2    1    0    1    2    3    4     5
 [6,]    5    4    3    2    1    0    1    2    3     4
 [7,]    6    5    4    3    2    1    0    1    2     3
 [8,]    7    6    5    4    3    2    1    0    1     2
 [9,]    8    7    6    5    4    3    2    1    0     1
[10,]    9    8    7    6    5    4    3    2    1     0
> 
```

How to create the matrix if there is no toeplitz function? 
I get the solution from my friend.

```r
> t <- 10
> a <- abs(rep(1:t, t) - rep(1:t, each=t))
> m <- matrix(a, ncol=t)
> m
      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
 [1,]    0    1    2    3    4    5    6    7    8     9
 [2,]    1    0    1    2    3    4    5    6    7     8
 [3,]    2    1    0    1    2    3    4    5    6     7
 [4,]    3    2    1    0    1    2    3    4    5     6
 [5,]    4    3    2    1    0    1    2    3    4     5
 [6,]    5    4    3    2    1    0    1    2    3     4
 [7,]    6    5    4    3    2    1    0    1    2     3
 [8,]    7    6    5    4    3    2    1    0    1     2
 [9,]    8    7    6    5    4    3    2    1    0     1
[10,]    9    8    7    6    5    4    3    2    1     0
```

interesting part is the usage of <code>rep</code>

```r
> t = 5
> matrix(rep(1:t,t),ncol=t)
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    1    1    1    1
[2,]    2    2    2    2    2
[3,]    3    3    3    3    3
[4,]    4    4    4    4    4
[5,]    5    5    5    5    5
> matrix(rep(1:t,each=t),ncol=t)
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    2    3    4    5
[2,]    1    2    3    4    5
[3,]    1    2    3    4    5
[4,]    1    2    3    4    5
[5,]    1    2    3    4    5
> 
```

in R, there are other ways to create special matrix,
such as 

```r
> matrix(1,3,3)                                                                
     [,1] [,2] [,3]
[1,]    1    1    1
[2,]    1    1    1
[3,]    1    1    1
> matrix(0,3,3)                                                                
     [,1] [,2] [,3]
[1,]    0    0    0
[2,]    0    0    0
[3,]    0    0    0
```

TODO: create other kinds of special matrix in R





