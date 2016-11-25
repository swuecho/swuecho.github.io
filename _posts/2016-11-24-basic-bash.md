---
layout: post
title:  basic bash 
date:   2016-11-24 19:51 
categories: tech 
---



## for loop

```{bash}
# output 1 to 50
for i in $(seq 1 50)
do 
   echo $i 
done
```
## while 

```{bash}
while condition
do
    statements
done
```

## if 

```{bash}
if condition
then
    statements
[elif condition
    then statements ...]
[else
    statements]
fi
```

