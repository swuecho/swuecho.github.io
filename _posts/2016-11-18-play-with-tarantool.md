---
layout: post
title:  play with tarantool 
date:   2016-11-18 19:18 
categories: tech 
---


## recover from previous session

go to the data directory, start tarantoll and run box.cfg(), and that is it.

```
➜  tarantool_sandbox tarantool
tarantool: version 1.7.2-235-gd058363
type 'help' for interactive help
tarantool> box.cfg()
2016-11-18 19:16:58.975 [6873] main/101/interactive C> version 1.7.2-235-gd058363
2016-11-18 19:16:58.975 [6873] main/101/interactive C> log level 5
2016-11-18 19:16:58.975 [6873] main/101/interactive I> mapping 1073741824 bytes for tuple arena...
2016-11-18 19:16:58.979 [6873] main/101/interactive I> recovery start
2016-11-18 19:16:58.979 [6873] main/101/interactive I> recovering from `./00000000000000000000.snap'
2016-11-18 19:16:58.981 [6873] main/101/interactive I> recover from `./00000000000000000000.xlog'
2016-11-18 19:16:58.982 [6873] main/101/interactive I> done `./00000000000000000000.xlog'
2016-11-18 19:16:58.982 [6873] main/102/hot_standby I> recover from `./00000000000000000000.xlog'
2016-11-18 19:16:58.982 [6873] main/101/interactive I> done `./00000000000000000000.xlog'
2016-11-18 19:16:58.983 [6873] main/101/interactive I> ready to accept requests
---
...

tarantool> box.space.tester:select()
---
- - [1]
  - [2, 'Music']
  - [3, 'Length', 93]
...
tarantool> 
```

edit: config with port, so can connect

```
tarantool> box.cfg{listen = 3302}
---
...

tarantool> box.cfg.listen
---
- '3302'
...
```

## list spaces


```
function list_spaces()
  local tuple_count, space_name, line
  local ta = {}
  for k, v in box.space._space:pairs() do
    space_name = v[3]
	if string.sub(space_name,0,1) ~= '_' then 
    if box.space[space_name].index[0] ~= nil then
      tuple_count = '1 or more'
    else
      tuple_count = '0'
    end
    line = space_name .. ' tuple_count =' .. tuple_count
    if tuple_count == '1 or more' then
      for k1, v1 in box.space[space_name]:pairs() do
        line = line .. '. first field in first tuple = ' .. v1[1]
        break
      end
    end
	end
    table.insert(ta, line)
  end
  return ta
end
```

