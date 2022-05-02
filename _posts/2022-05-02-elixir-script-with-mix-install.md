---
layout: post
title:  elixir script with mix install 
date:   2022-05-02 05:20 
categories: tech
---
```
![](_posts/image/2022-05-02-elixir-script-with-mix-install/1651468934185.png)
```

```➜
github-repos.exs  json_hello.exs  postgresx.exs
➜  elixir git:(master) cat json_hello.exs
Mix.install([:jason])
IO.puts(Jason.encode!(%{hello: :world}))
➜  elixir git:(master) elixir json_hello.exs
{"hello":"world"}
```

```

```
