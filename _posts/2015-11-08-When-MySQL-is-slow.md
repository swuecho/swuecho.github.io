---
layout: post
title:  When MySQL is slow 
date:   2015-11-08 09:28 
categories: tech 
---

# alter table

```{bash}
mysql alter table is to slow
mysql> ALTER TABLE OPERA_ORATORIO ADD nseq_length smallint
    -> ;
Query OK, 15048730 rows affected (3 hours 8 min 3.72 sec)
Records: 15048730  Duplicates: 0  Warnings: 0
```

as the answer said, better to create new table to replace the old one
http://stackoverflow.com/questions/12774709/mysql-very-slow-for-alter-table-query



