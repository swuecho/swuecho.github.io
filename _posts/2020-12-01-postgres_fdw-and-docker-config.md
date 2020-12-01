---
layout: post
title:  postgres_fdw and docker config 
date:   2020-12-01 18:37 
categories: tech 
---

## enable extension and create remote server and add user mapping

```sql
--  with super user,  at sink database
CREATE EXTENSION postgres_fdw; -- enable postgres fdw;

grant usage on FOREIGN DATA WRAPPER postgres_fdw to admin;

CREATE SERVER admin_db_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host '127.0.0.1', dbname 'admin', port '5432');

GRANT USAGE ON FOREIGN SERVER admin_db_server TO admin;

CREATE USER MAPPING FOR admin
SERVER admin_db_server
OPTIONS (user 'admin', password 'secret_password');
```

## adjust docker config

if postgres auth config is `trust`, postgres will not create the admin server for you.

```sh
      POSTGRES_USER: "postgres"
      POSTGRES_PASSWORD: "your_superuser_pass"
      POSTGRES_INITDB_ARGS: "--auth=md5"
```

verify your postgres have right configuration:

```sh
docker-compose exec postgres_db_image cat /var/lib/postgresql/data/pg_hba.conf
```

##  import foreign schema

```sql

-- with admin user, in sink database
IMPORT FOREIGN SCHEMA public
LIMIT TO (survey)
FROM SERVER admin_db_server
INTO public;



IMPORT FOREIGN SCHEMA public
LIMIT TO ("user")
FROM SERVER admin_db_server
INTO public;


```

That is it!

