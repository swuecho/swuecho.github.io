---
layout: post
title:  Add command to nvim using Lua to change word at cursor 
date:   2020-12-19 14:57 
categories: tech 
---


## problem:

change a word from `camelCase` to `snake_case` in nvim


## change word from `camelCase` to `snake_case` using Lua

```lua
string.gsub(word, "(%u)", "_%1" )
```

## write a lua function 

```
local api = vim.api
local M = {}

function M.snake_case()
    -- expand('<cword>') to get the current word under cursor
    local current_word = vim.call('expand','<cword>') 
    -- change case
    local snake_case_word = string.gsub(current_word, "(%u)", "_%1" )
    -- diw delete in word
    -- i insert
    -- and add snake_case_word
    vim.cmd("normal! diwi" ..  snake_case_word)
end

return M
```

## call the function 

```
:lua require'hao'.snake_case()
``

However, it seems not worth the trouble to write such a long command to change the case.

Of Course, there is a better way. stay tuned.

