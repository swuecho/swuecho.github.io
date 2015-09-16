---
layout: post
title:  install plr in postgresql 
date:   2015-09-16 09:24 
categories: tech 
---

# Install plr extension in postgresql

## install R
 
{% highlight bash %}

sudo yum install epel-release
sudo yum install R

{% endhighlight %}
 


## make sure postgresql94-devel is installed, so we can use PGXS
 
{% highlight bash %}
sudo yum install postgresql94-devel
{% endhighlight %}

# install plr

{% highlight bash %}

wget https://github.com/jconway/plr/archive/REL8_3_0_16.zip
unzip REL*
cd plr-REL8_3_0_16
PATH=/usr/pgsql-9.4/bin/:$PATH; USE_PGXS=1 make
echo 'PATH=/usr/pgsql-9.4/bin/:$PATH; USE_PGXS=1 make install' | sudo sh
# plr install complete

{% endhighlight %}
 
 
## create extension in v70 db
 
{% highlight bash %}

psql -U postgres -d db_name -c 'CREATE EXTENSION plr;'

{% endhighlight %}

