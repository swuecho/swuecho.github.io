---
layout: post
title:  Assocate Array in Zsh 
date:   2015-11-08 09:26 
categories: tech 
---

Associate Array in Zsh



    $ typeset -A asso_array; asso_array=(one 1 two 2 three 3 four 4)

    $ print ${(k)asso_array} # prints keys
      one four two three
    $ print ${(v)asso_array} # prints values
      1 4 2 3

    #iterate over associate array

    for k in "${(@k)asso_array}"; do
        echo "$k -> $asso_array[$k]"
    done



