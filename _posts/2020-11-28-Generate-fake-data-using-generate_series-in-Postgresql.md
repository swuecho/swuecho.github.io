---
layout: post
title:  Generate fake data using generate_series in Postgresql 
date:   2020-11-28 16:10 
categories: tech 
---

When read the book "Postgres for Data Architects", in Chapter 4, the book use web2py to generate sample data.
After wasting sometime on reading through the web2py api. I decide to use sql to generate the data directly.


```
CREATE TABLE account (id serial PRIMARY KEY ,
first_name varchar(100), last_name varchar(100), account_bal numeric (10,2));

INSERT INTO account(first_name, last_name, account_bal)
SELECT
  'first_' || seq  AS first_name,
  'last_' || seq  AS last_name,
   CASE (RANDOM() * 2)::INT
      WHEN 0 THEN 0
      WHEN 1 THEN 100
      WHEN 2 THEN 1000
   END
  as account_bal
FROM GENERATE_SERIES(1, 1000000) seq;

```

If better fake data is required, use `Faker` to generate the raw data and insert to db is a better option.

ref:

https://www.simononsoftware.com/generating-random-data-in-postgresql/
https://www.citusdata.com/blog/2018/03/14/fun-with-sql-generate-sql/
https://letstalkdata.com/2013/08/postgresql-generate_series-tricks/
