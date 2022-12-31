---
layout: post
title:  sqlalchemy performance trap 
date:   2022-12-11 11:39 
categories: tech 
---

## even a query will open a transcation.

this is ugly true due to sqlalchemy and pycogpg.

## base model object expire after `commit`

sqlalchemy session maintain state of base model object.  once a commit happen.
all object in the session will be marked expired. when accesssed, the object will be fetch again on demand.
As a result, there might be huge performance overhead.

```python
locations = session.query(Location).all() # one query
session.commit() # one commit
for loc in locatons: # N query, N is the len(locations)
        print(loc.name)
```

the code above will issue `N+2` query instead of 3.

```python
locations = session.query(Location).all() # one query
session.commit() # one commit
locations = session.query(Location).all() # one query
for loc in locatons: 
        print(loc.name)
```

the code above only hit DB with 3 query and will be significantly faster if location count is large.

This is the biggest performace problem if commit (state of sqlalchemy base model object) is ignored.



