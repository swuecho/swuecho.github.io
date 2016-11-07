---
layout: post
title:  Postgresql Windows Function 
date:   2016-09-20 17:41 
categories: tech 
---

NOTE: the data in this blog come from  http://postgresguide.com/tips/window.html

```{python}
hwu=# select * from demo_sales ;
 last_name | salary | department | rank
-----------+--------+------------+------
 Jones     |  45000 | Accounting |    1
 Williams  |  37000 | Accounting |    2
 Smith     |  55000 | Sales      |    1
 Adams     |  50000 | Sales      |    2
 Johnson   |  40000 | Marketing  |    1
(5 rows)
```


## group by 
```{python}
hwu=# select department, sum(salary) from demo_sales group by department;
 department |  sum
------------+--------
 Accounting |  82000
 Marketing  |  40000
 Sales      | 105000
(3 rows)
```


## aggregate window function

```{python}
hwu=# select last_name,department, sum(salary) OVER (PARTITION BY department) from demo_sales;
 last_name | department |  sum
-----------+------------+--------
 Jones     | Accounting |  82000
 Williams  | Accounting |  82000
 Johnson   | Marketing  |  40000
 Smith     | Sales      | 105000
 Adams     | Sales      | 105000
(5 rows)

```

compare the query above and try to understand this from postgresql manual "A window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. But unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row — the rows retain their separate identities. Behind the scenes, the window function is able to access more than just the current row of the query result."



## window function with order by

seems if 'order by' is addded. the aggreage funciton is called on the rows in the partition to current row, instead all of them
```{python}
hwu=# select last_name,department, sum(salary) OVER (PARTITION BY department order by salary) from demo_sales;
 last_name | department |  sum
-----------+------------+--------
 Williams  | Accounting |  37000
 Jones     | Accounting |  82000
 Johnson   | Marketing  |  40000
 Adams     | Sales      |  50000
 Smith     | Sales      | 105000
(5 rows)

```


PS: the code to insert the data to postgresql without write query.

```{python}
# turn a csv to a table in postgresql database
import pandas
from sqlalchemy import create_engine
import os

db_string = os.environ['DATABASE_URL']
conn = create_engine(db_string).connect()

df = pandas.read_csv("./group_data.csv")
df.to_sql('demo_sales', conn, index=False)

```
