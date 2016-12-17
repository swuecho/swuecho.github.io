---
layout: post
title:  DB norm form note 
date:   2016-12-15 10:35 
categories: tech 
---

### informal Design Guidelines for Relation Schemas

1. Make sure the sematics of the attributes in clear in the schema.
2. Reducing the redundant information in the tuples.
3. Reducing the Null values in tuples.
4. Disabling the possibility of generating spurious tuples.

### Functional Dependency

X -> Y

the values of component in Y is depend on or determined by, the value of X component

X is the left side of the Functional Dependency
Y is the right side of the Functional Dependency


### Keys

superkey: a set of attribites can uniquely distinguish a item in a relation.

key: a minimal superkey

candidate key: if a relation schema have more than 1 key, then each key is called a candidate key.

primary key: one of the candidate key can be arbitrarily designated to be the primary key.


### Normal Form

1NF: a dormain of an attribute mush only include atomic (simple, indivisible) value.
2NF: based on full functional dependency.

A relation schema is 2NF if every noneprime attribute A in R is fully functional dependent on the primary key of R.

  
