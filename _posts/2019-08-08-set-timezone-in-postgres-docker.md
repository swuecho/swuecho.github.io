---
layout: post
title:  set timezone in postgres docker 
date:   2019-08-08 11:50 
categories: tech 
---

After set in docker-compose file,

```
 environment:
        TZ: 'GMT-8'
        PGTZ: 'GMT-8'

```

run the query,

```
db => select now();
              now
-------------------------------
 2019-08-07 19:21:17.584412-08
(1 row)

db => show timezone;
 TimeZone
----------
 GMT+8
(1 row)
```


```
db => select * from pg_timezone_names where name LIKE '%Shanghai%';
        name         | abbrev | utc_offset | is_dst
---------------------+--------+------------+--------
 posix/Asia/Shanghai | CST    | 08:00:00   | f
 Asia/Shanghai       | CST    | 08:00:00   | f
(2 rows)
```

from the result, realize that timezone in China is GMT-8, not GMT+8


```
db => show timezone;
 TimeZone
----------
 GMT-8
(1 row)

db => select  now();
              now
-------------------------------
 2019-08-08 11:53:14.399764+08
(1 row)
```

## Summary:

Timezone in China is CST, which is GMT-8 not GMT+8
