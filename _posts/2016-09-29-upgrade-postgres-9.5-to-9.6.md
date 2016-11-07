---
layout: post
title:  upgrade postgres-9.5 to 9.6 in ubuntu
date:   2016-09-29 11:14 
categories: tech 
---

```{bash}
sudo service postgresql stop
sudo apt-get install postgresql-9.6
sudo service postgresql staus
sudo service postgresql start
```

## dump all the data

```{bash}
pg_dumpall >9.5.db
```

## fix pg_hba

if you try to connect

        psql -p 5433 -U postgres  

will get error
    
        FATAL: Peer authentication failed for user "postgres"

check http://stackoverflow.com/questions/18664074

the problem is still your pg_hba.conf file (/etc/postgresql/9.1/main/pg_hba.conf). This line:

    local   all             postgres                                peer

Should be

    local   all             postgres                                md5




## after change the config

    psql -p 5433 -U postgres -f  9.5.db
    sudo service postgresql stop
    sudo apt-get purge postgresql-9.5


and then,  chage peer to trust, and the change back to 'md5'


## finally, restart to db

    sudo service postgresql start
