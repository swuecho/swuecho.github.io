---
layout: post
title:  psql commanand line
date:   2014-08-04 14:08:00
categories: tech 
---

Common psql command line 

```{sql}

# List of databases 
\l  
  
# connect to a database
 \c hao_70 #
...
You are now connected to database "hao_70" as user "appuser".

hao_70=> \dt
              List of relations
 Schema |       Name       | Type  |  Owner
--------+------------------+-------+---------
 public | action           | table | appuser
…
(14 rows)

hao_70=> \dn
    List of schemas
    Name     |  Owner
-------------+----------
 base_panel  | appuser
 base_survey | appuser
 ds1         | appuser
 ds2         | appuser
 public      | postgres
(5 rows)

# show current search_path
hao_70=> show search_path;
  search_path
----------------
 "$user",public
(1 row)

# set search_path
hao_70=> set search_path=ds1;
SET

# show all tables in a schema

hao_70=> \dt
                 List of relations
 Schema |          Name          | Type  |  Owner
--------+------------------------+-------+---------
 ds1    | activity_log           | table | appuser

# descibe a table
hao_70=> \d report
                                              Table "ds1.report"
     Column      |          Type          |             Modifiers
-----------------+------------------------+--------------------------------
 report_id       | integer                | 
 url             | text                   |
 title           | character varying(100) |

TODO: ;
# watch the query every sencond 
select * from dataset; \watch 1; 

```
