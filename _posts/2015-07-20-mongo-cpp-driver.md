---
layout: post
title:  mongo cpp driver 
date:   2015-07-20 10:39 
categories: tech 
---
There is some document there, but takes time for me to find it.
besides, the build command change compared with the 26compat branch

{% highlight bash %}

# install some requirement

# http://www.cyberciti.biz/faq/installing-rhel-epel-repo-on-centos-redhat-7-x/
sudo yum install boost boost-devel gcc-c++ scons -y

git clone https://github.com/mongodb/mongo-cxx-driver.git

# checkout the legacy branch, legacy branch is the recommended for 3.0
cd mongo-cxx-driver
git checkout legacy
sudo scons --sharedclient --prefix=/usr/local install
sudo ldconfig

```

