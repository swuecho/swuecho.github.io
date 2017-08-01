---
layout: post
title:  cpanm install location 
date:   2017-08-01 16:26 
categories: tech 
---

cpanm will use PERL_MB_OPT



``` 
# user perl -V to show this
PERL_MB_OPT="--install_base "/home/hwu/perl5""
PERL_MM_OPT="INSTALL_BASE=/home/hwu/perl5"
```

if this is not what you want, 

```
export PERL_MB_OPT 
export PERL_MM_OPT 
```

will install the previous set location


