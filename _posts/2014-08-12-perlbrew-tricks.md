---
layout: post
title:  perlbrew tricks
date:   2014-08-12 20:53 
categories: tech 
---
when set up cron jobs, you can use perlbrew save you 
a lot of time

{% highlight bash %}
0 23  * * * /path/to/perlbrew exec --with perl-5.20.0 perl /path/to/app.pl > /dev/null
```

