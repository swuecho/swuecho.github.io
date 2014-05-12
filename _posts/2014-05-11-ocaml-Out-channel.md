---
layout: post
title:  "Ocaml module Out_Channel"
date:   2014-05-11 15:55:00
categories: tech
---

 have to have some line in the doc, not code only

{% highlight ocaml %}


utop # module M = Out_channel;;
module M :  
   sig
    type t = out_channel
    val stdout : t
    val stderr : t
    type 'a with_create_args = ?binary:bool -> ?append:bool -> ?perm:int -> 'a
    val create : (string -> t) with_create_args
    val with_file : (string -> f:(t -> 'a) -> 'a) with_create_args
    val close : t -> unit
    val set_binary_mode : t -> bool -> unit
    val flush : t -> unit
    val output : t -> buf:string -> pos:int -> len:int -> unit
    val output_string : t -> string -> unit
    val output_char : t -> char -> unit
    val output_byte : t -> int -> unit
    val output_binary_int : t -> int -> unit
    val output_value : t -> 'a -> unit
    val newline : t -> unit
    val output_lines : t -> string list -> unit
    val seek : t -> int64 -> unit
    val pos : t -> int64
    val length : t -> int64
    val write_lines : string -> string list -> unit
    val write_all : string -> data:string -> unit
  end
{% endhighlight %}
