---
layout: post
title:  "Postgres 9.3.4 install and running in Mac OS"
date:   2014-05-18 15:38:00
categories: tech
---


## install

    brew install postgres

all the db are initalized belong to the current user

## start

    pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

## stop

    pg_ctl -D /usr/local/var/postgres stop -s -m fast


## psql

    psql postgres


# 1.2 Creating a Database and a Sample Table.




## create and connect to a db

create a db named cookbook

    createdb cookbook

enter the db through command line

    psql cookbook

List all dbs.

    \l

connenct to a db

    \c dbname

## create a table

{% highlight SQL %}

    CREATE TABLE limbs ( thing VARCHAR(20), legs  INT, arms  INT);

    INSERT INTO limbs (thing,legs,arms) VALUES('human',2,2);
    INSERT INTO limbs (thing,legs,arms) VALUES('insect',6,0);
    INSERT INTO limbs (thing,legs,arms) VALUES('squid',0,10);
    INSERT INTO limbs (thing,legs,arms) VALUES('octopus',0,8);
    INSERT INTO limbs (thing,legs,arms) VALUES('fish',0,0);
    INSERT INTO limbs (thing,legs,arms) VALUES('centipede',100,0);
    INSERT INTO limbs (thing,legs,arms) VALUES('table',4,0);
    INSERT INTO limbs (thing,legs,arms) VALUES('armchair',4,2);
    INSERT INTO limbs (thing,legs,arms) VALUES('phonograph',0,1);
    INSERT INTO limbs (thing,legs,arms) VALUES('tripod',3,0);
    INSERT INTO limbs (thing,legs,arms) VALUES('Peg Leg Pete',1,2);
    INSERT INTO limbs (thing,legs,arms) VALUES('space alien',NULL,NULL);

```

# basic query to verify the insertion

{% highlight SQL %}
cookbook=# select * from limbs;
    thing     | legs | arms
--------------+------+------
 human        |    2 |    2
 insect       |    6 |    0
 squid        |    0 |   10
 octopus      |    0 |    8
 fish         |    0 |    0
 centipede    |  100 |    0
 table        |    4 |    0
 armchair     |    4 |    2
 phonograph   |    0 |    1
 tripod       |    3 |    0
 Peg Leg Pete |    1 |    2
 space alien  |      |
(12 rows)

```
