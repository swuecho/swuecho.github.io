---
layout: post
title:  Perl Surprise 
date:   2017-02-25 19:22 
categories: tech 
---

what is the output  of the following program?

```perl
use v5.10;
for (split //, "ABCDEFG") { 
    print $_; 
    say if $_ ==  " ";
}

say "blank string" if "";
say "string with one space" if " ";
say "one space equal one space " if " " == " ";
say "one space equal none space " if " " ==  "";
```
This is when I feel perl is too much surprise.


