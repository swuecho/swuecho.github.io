---
layout: post
title:  "Ocaml Small Recipes"
date:   2014-06-11 22:08:00
categories: tech 
---


### get the current time

{% highlight ocaml %}
utop [4]: Time.now ();;
- : Time.t = 2014-05-24 20:12:53.256230-07:00
{% endhighlight %}


### create a UUID 
{% highlight ocaml %}
utop [0]: Uuid.create ();;
- : Uuid.t = 703783af-cffc-3a32-0386-cb38100dc0c9  
{% endhighlight %}
