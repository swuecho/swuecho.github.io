---
layout: post
title:  elixir script with mix install 
date:   2022-05-02 05:20 
categories: tech
---

![](/assets/img/elixir_script.png)

```bash
github-repos.exs  json_hello.exs  postgresx.exs
➜  elixir git:(master) cat json_hello.exs
Mix.install([:jason])
IO.puts(Jason.encode!(%{hello: :world}))
➜  elixir git:(master) elixir json_hello.exs
{"hello":"world"}
```