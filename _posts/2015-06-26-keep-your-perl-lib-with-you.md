---
layout: post
title:  keep your perl lib with you 
date:   2015-06-26 21:40 
categories: tech 
---

### install plenv, perl buld plugin

Follow the instruction here

http://www.dagolden.com/index.php/2390/setting-up-a-perl-development-environment-with-plenv/

### install libs. 

I keep my own lib in a ~/Std, all other module I need to install from cpan is 
in a cpanfile.

####  install modules into specified directory by -L option.

    cpanm -L ~/perl5  --installdeps .

above command will install all the module in the cpanfile

#### add Std and perl5 to PERL5LIB

    export PERL5LIB=$PERL5LIB:~/Std/lib/:/home/hwu/perl5/lib/perl5

### start hacking with shining perl and your favorite libs

