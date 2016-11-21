---
layout: post
title:  Ocaml Sqlite3 Tutorial I 
date:   2016-11-21 14:03 
categories: tech 
---
I am looking at Ocaml and SQLite. Surprisely, can not find a tutorial, so here it is.


## install sqlite3-ocaml binding

```
opam install Sqlite3
```

## The document

http://mmottl.github.io/sqlite3-ocaml/API.docdir/

Rant: To me, a newbie in Ocaml, the doc is useless, as most of other ocaml doc

## Where is the example?

Luckly, we can find some in the test directory of the src

such as:

https://raw.githubusercontent.com/mmottl/sqlite3-ocaml/master/test/test_exec.ml

```{ocaml}
open Printf
open Sqlite3

exception Dummy

let () =
  let db = db_open "t" in
  for i = 0 to 10 do
    try
      let sql =
        sprintf "CREATE TABLE tbl%d (a varchar(1), b INTEGER, c FLOAT)" i
      in
      printf "%d %s\n%!" i sql;
      match exec db sql ~cb:(fun _ _ -> print_endline "???") with
      | Rc.OK -> ()
      | _ -> assert false
    with xcp -> print_endline (Printexc.to_string xcp)
  done;
  for i = 0 to 3 do
    let sql = sprintf "SYNTACTICALLY INCORRECT SQL STATEMENT" in
    printf "%d %s\n%!" i sql;
    try
      match exec db sql ~cb:(fun _ _ -> print_endline "???") with
      | Rc.ERROR -> printf "Identified error: %s\n" (errmsg db)
      | _ -> assert false
    with xcp -> print_endline (Printexc.to_string xcp)
  done;
  for i = 0 to 3 do
    let sql = sprintf "INSERT INTO tbl%d VALUES ('a', 3, 3.14)" i in
    printf "%d %s\n%!" i sql;
    try
      match exec db sql ~cb:(fun _ _ -> print_endline "???") with
      | Rc.OK -> printf "Inserted %d rows\n%!" (changes db)
      | _ -> assert false
    with xcp -> print_endline (Printexc.to_string xcp)
  done;
  let sql = sprintf "SELECT * FROM tbl0" in
  for _i = 0 to 3 do
    try
      print_endline "TESTING!";
      match
        exec db sql ~cb:(fun _ _ -> print_endline "FOUND!"; raise Dummy)
      with
      | Rc.OK -> print_endline "OK"
      | _ -> assert false
    with xcp -> print_endline (Printexc.to_string xcp)
  done
```

Wait, How can I run it?

if you are in Python, Perl or Ruby land, just run it and done.

But that is ocaml, you do not get the luck.


## Two Option

### OCaml as shell scripting

First is run it as OCaml as shell scripting

check https://ocaml.org/learn/tutorials/get_up_and_running.html

Basicly, You need to let ocaml find the where the library you used

```{ocaml}
#!/usr/bin/env ocaml
(* Need topfind to make require work, need require to use podge package *)
#use "topfind"
#require "podge"

```

because we use sqlite3, so we need to modify it a bit 
```{ocaml}
#!/usr/bin/env ocaml
(* Need topfind to make require work, need require to use sqlite3 package *)
#use "topfind"
#require "sqlite3"
```
and add the above code to test_exec.ml

lastly, 
```
chmod +x test_exec.ml
```


### Compile and Run


```
ocamlfind ocamlc -linkpkg -package sqlite3 test_exec.ml -o test.byte
./test.byte
```

Why? what is ocamlfind? Ok, We need a ocamlfind tutorial


## Conclusion

We installed the Sqlite3 module and successfly runed one example. This is the very first step in using SQLite with Ocaml.
