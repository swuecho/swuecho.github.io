---
layout: post
title:  "Ocaml module In_Channel"
date:   2014-05-11 15:47:00
categories: tech
---


{% highlight ocaml %}
module M :                                                                                                                                                                                                                                    sig                                                                                                                                                                                                                                           type t = in_channel
    val stdin : t
    val create : ?binary:bool -> string -> t
    val with_file : ?binary:bool -> string -> f:(t -> 'a) -> 'a
    val close : t -> unit
    val input : t -> buf:string -> pos:int -> len:int -> int
    val really_input : t -> buf:string -> pos:int -> len:int -> unit option
    val input_byte : t -> int option
    val input_char : t -> char option
    val input_binary_int : t -> int option
    val unsafe_input_value : t -> 'a option
    val input_all : t -> string
    val input_line : ?fix_win_eol:bool -> t -> string option
    val fold_lines : ?fix_win_eol:bool -> t -> init:'a -> f:('a -> string -> 'a) -> 'a
    val input_lines : ?fix_win_eol:bool -> t -> string list
    val iter_lines : ?fix_win_eol:bool -> t -> f:(string -> unit) -> unit
    val seek : t -> int64 -> unit
    val pos : t -> int64
    val length : t -> int64
    val set_binary_mode : t -> bool -> unit
    val read_lines : string -> string list
    val read_all : string -> string
  end

{% endhighlight %}
