---
layout: post
title:  cpanm install location 
date:   2017-08-01 16:26 
categories: tech 
---

By default local::lib installs itself and the CPAN modules into ~/perl5.
sometimes, this is not what you want. you can disable it

local::lib will use PERL_MB_OPT, PERL_MM_OPT

``` 
# user perl -V to show this
PERL_MB_OPT="--install_base "/home/hwu/perl5""
PERL_MM_OPT="INSTALL_BASE=/home/hwu/perl5"
```
#### disable 
```
export PERL_MB_OPT 
export PERL_MM_OPT 
```

#### or better way 

```
eval $(perl -Mlocal::lib=--deactivate-all)
```

```
unset PERL_MB_OPT;
unset PERL_MM_OPT;
```

after this. cpanm will install the previous location


