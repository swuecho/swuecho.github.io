---
layout: post
title:  Ocaml Sqlite3 Tutorial II
date:   2016-11-21 14:03 
categories: tech 
---
The code blow are modifed from http://www.mega-nerd.com/erikd/Blog/CodeHacking/Ocaml/snip_sqlite.html

I split the orginal problem into parts and fix the bugs in search_iterator

## Create Table
```{ocaml}
#!/usr/bin/env ocaml
#use "topfind"
#require "sqlite3"
#require "unix"
open Sqlite3
open Printf
open Unix

exception E of string

let create_tables db =
  (* Create two tables in the database. *)
  let tables =
    [ "people", "pkey INTEGER PRIMARY KEY, first TEXT, last TEXT, age INTEGER" ;
      "cars", "pkey INTEGER PRIMARY KEY, make TEXT, model TEXT" ;
    ]
  in
  let make_table (name, layout) =
    let stmt = Printf.sprintf "CREATE TABLE %s (%s);" name layout in
    match Sqlite3.exec db stmt with
    |    Sqlite3.Rc.OK -> Printf.printf "Table '%s' created.\n" name
    |    x -> raise (E (Sqlite3.Rc.to_string x))
  in
  List.iter make_table tables



(* Program main. *)

let () =
  (* The database is called test.db. Delete it if it already exists. *)
  let db_filename = "test.db" in
  (    try Unix.unlink db_filename
       with _ -> ()
  ) ;

  (* Create a new database. *)
  let db = Sqlite3.db_open db_filename in

  create_tables db ;

  (* Close database when done. *)
  if Sqlite3.db_close db then print_endline "All done.\n"
  else print_endline "Cannot close database.\n"
```

## Insert Data
```{ocaml}
#!/usr/bin/env ocaml
(* Need topfind to make require work, need require to use podge package *)
#use "topfind"
#require "sqlite3"
open Sqlite3

exception E of string


let insert_data db =
  (* Insert data in both the tables. *)
  let people_data =
    [    "John", "Smith", 23;
         "Helen", "Jones", 29 ;
         "Adam", "Von Schmitt", 32 ;
    ]
  in
  let car_data =
    [    "bugatti", "veyron" ;
         "porsche", "911" ;
    ]
  in
  let insert_people (first, last, age) =
    (* Use NULL for primary key and Sqlite will generate a unique key. *)
    let stmt = Printf.sprintf "INSERT INTO people values (NULL, '%s', '%s', %d);"
        first last age
    in
    match Sqlite3.exec db stmt with
    |    Sqlite3.Rc.OK -> ()
    |    x -> raise (E (Sqlite3.Rc.to_string x))
  in
  let insert_car (make, model) =
    let stmt = Printf.sprintf "INSERT INTO cars values (NULL, '%s', '%s');"
        make model
    in
    match Sqlite3.exec db stmt with
    |    Sqlite3.Rc.OK -> ()
    |    x -> raise (E (Sqlite3.Rc.to_string x))
  in
  List.iter insert_people people_data ;
  List.iter insert_car car_data ;
  print_endline "Data inserted."

(* Program main. *)

let () =
  (* The database is called test.db. Delete it if it already exists. *)
  let db_filename = "test.db" in
  (* Create a new database. *)
  let db = Sqlite3.db_open db_filename in

  insert_data db ;

  (* Close database when done. *)
  if Sqlite3.db_close db then print_endline "All done.\n"
  else print_endline "Cannot close database.\n"

```

## Query Data
             

```{ocaml}
#!/usr/bin/env ocaml
(* Need topfind to make require work, need require to use podge package *)
#use "topfind"
#require "sqlite3"
open Sqlite3

exception E of string



let search_iterator db =
  (* Perform a simple search. *)
  let str_of_rc rc =
    match rc with
    |    Sqlite3.Data.NONE -> "none"
    |    Sqlite3.Data.NULL -> "null"
    |    Sqlite3.Data.INT i -> Int64.to_string i
    |    Sqlite3.Data.FLOAT f -> string_of_float f
    |    Sqlite3.Data.TEXT s -> s
    |    Sqlite3.Data.BLOB _ -> "blob"
  in
  let dump_output s =
    Printf.printf "  Row   Col   ColName    Type       Value\n%!"  ;
    let row = ref 0 in
    while Sqlite3.step s = Sqlite3.Rc.ROW do
      for col = 0 to Sqlite3.data_count s - 1 do
        let type_name = 
              match Sqlite3.column_decltype s col with
                    | Some name ->  name
                    | None -> "unknow type" 
              in
        let val_str = str_of_rc (Sqlite3.column s col) in
        let col_name = Sqlite3.column_name s col in
        Printf.printf "  %2d  %4d    %-10s %-8s   %s\n%!"
          !row col col_name type_name val_str ;
      done ;
      row := succ !row ;
    done
  in
  print_endline "People over 25 years of age :" ;
  let stmt = Sqlite3.prepare db "SELECT * FROM people WHERE age > 25;" in
  dump_output stmt    ;
  match Sqlite3.finalize stmt with
  |    Sqlite3.Rc.OK -> ()
  |    x -> raise (E (Sqlite3.Rc.to_string x))


(* Program main. *)

let () =
  (* The database is called test.db. Delete it if it already exists. *)
  let db_filename = "test.db" in

  (* Create a new database. *)
  let db = Sqlite3.db_open db_filename in

  search_iterator db ;

  (* Close database when done. *)
  if Sqlite3.db_close db then print_endline "All done.\n"
  else print_endline "Cannot close database.\n"
```

in the problem above, 
Sqlite3.column_decltype return option string, so I have to add pattern match to make it work.

```{ocaml}

        let type_name = 
              match Sqlite3.column_decltype s col with
                    | Some name ->  name
                    | None -> "unknow type" 
              in
```{ocaml}
