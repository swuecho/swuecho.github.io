---
layout: post
title:  sql: data to table 
date:   2022-12-31 03:25 
categories: tech 
---

## sql: transfrom data to table 

### array to table

![](assets/img/sql_data_to_table.png)

```
select
  survey_id
from
  (
    select
      UNNEST(regexp_split_to_array('1,2,4', ','))
  ) as dt(survey_id)
```

note: seems the `dt(survey_id)` is required

