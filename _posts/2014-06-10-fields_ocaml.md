---
layout: post
title:  "Ocaml core extension fieldlib"
date:   2014-06-10 22:08:00
categories: tech 
---

# useful but strange

```{ocaml}
utop [19]: User.last_name me;;
- : string = "Wu"
  utop [20]: User.first_name me;;
- : string = "Hao" 
  utop [21]: me.User.first_name;;
- : string = "Hao" 
  utop [22]: me.User.last_name;;
- : string = "Wu"
  utop [23]: User.Fields.names;;
- : string list = ["first_name"; "last_name"]    

utop [32]: Field.get User.Fields.first_name;;
- : User.t -> string = <fun> 
  utop [33]: User.first_name;;
- : User.t -> string = <fun> 
  utop [34]: User.first_name me;;
- : string = "Hao"   

```

```{ocaml}

utop [1]: module User = struct
type t = { first_name : string; last_name:string } with fields
end;;
module User : sig
type t = { first_name : string; last_name : string; }
    val last_name : t -> string
    val first_name : t -> string
    module Fields :
      sig
        val names : string list
        val last_name : ([< `Read | `Set_and_create ], t, string) Field.t_with_perm
        val first_name : ([< `Read | `Set_and_create ], t, string) Field.t_with_perm
        val make_creator :
          first_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> 'a -> ('b -> string) * 'c) ->
          last_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> 'c -> ('b -> string) * 'd) -> 'a -> ('b -> t) * 'd
        val create : first_name:string -> last_name:string -> t
        val map :
          first_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> string) ->
          last_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> string) -> t
        val iter :
          first_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> 'a) ->
          last_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> 'b) -> 'b
        val fold :
          init:'a ->
          first_name:('a -> ([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> 'b) ->
          last_name:('b -> ([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> 'c) -> 'c
        val map_poly : ([< `Read | `Set_and_create ], t, 'a) Field.user -> 'a list
        val for_all :
          first_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> bool) ->
          last_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> bool) -> bool
        val exists :
          first_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> bool) ->
          last_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> bool) -> bool
        val to_list :
          first_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> 'a) ->
          last_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> 'a) -> 'a list
        module Direct :
          sig
            val iter :
              t ->
              first_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> t -> string -> 'a) ->
              last_name:(([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> t -> string -> 'b) -> 'b
            val fold :
              t ->
              init:'a ->
              first_name:('a -> ([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> t -> string -> 'b) ->
              last_name:('b -> ([< `Read | `Set_and_create ], t, string) Field.t_with_perm -> t -> string -> 'c) -> 'c
          end
      end
  end

```
