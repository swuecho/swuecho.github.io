---
layout: post
title:  pg_upgrade postgres from 9.3 to 9.4 
date:   2015-06-03 19:25 
categories: tech 
---

# Take a snapshot using virutalbox if you are worried about the data loss.

{% highlight bash %}

# add 9.4 repo

pg_url='http://yum.postgresql.org/9.4/redhat/rhel-7Server-x86_64/pgdg-centos94-9.4-1.noarch.rpm'
export LANG=en_US.UTF-8;
curl -O $pg_url; sudo rpm -ivh pgdg-centos94-9.4-1.noarch.rpm;
rm pgdg-centos94-9.4-1.noarch.rpm;

sudo yum update -y
sudo yum upgrade -y


sudo yum install -y postgresql94
sudo yum install -y postgresql94-server
sudo yum install -y postgresql94-devel
sudo yum install -y postgresql94-contrib # pg_update is part of contrib


sudo systemctl stop postgresql-9.3.service
sudo systemctl stop postgresql-9.4.service

su -
su postgres
cd

# run the upgrade

/usr/pgsql-9.4/bin/pg_upgrade -b /usr/pgsql-9.3/bin \ 
                              -B /usr/pgsql-9.4/bin -d /var/lib/pgsql/9.3/data \
                              -D /var/lib/pgsql/9.4/data 
                              -p 5432 -P 5433 
                               --user=postgres

su $YOU

sudo systemctl disable postgresql-9.4.service 
sudo systemctl start postgresql-9.4.service 


# analysis 

 "/usr/pgsql-9.4/bin/vacuumdb" -U "postgres" --all --analyze-only


# remove postgres-9.3

sudo yum erase postgresql93

#remove postgres-9.3 repo
sudo rm -rf /etc/yum.repos.d/pgdg-93-centos.repo

# rm data of 9.3. not very necessary
# su - 
# rm -rf  /var/lib/pgsql/9.3/data

{% endhighlight %}


# postgres basic 

all the config file is in the pddata dir, including pg_hba.conf postgresql.conf

    /var/lib/pgsql/9.4/data

the bin dir is 

    /usr/pgsql/9.4/bin

TODO: postgres auth manage


