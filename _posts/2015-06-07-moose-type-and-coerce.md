--- 
layout: post 
title: moose type and coerce 
date: 2015-06-07 21:04 
categories: tech
---

firstly, what is type and coerce?

let's see what is in the moose doc(Moose::Manual::Types)

### Type

It's important to realize that types are not classes(or packages). Types are just objects( Moose::Meta::TypeConstraint objects, to be exact ) with a name and a constraint. Moose maintains a global type registry that lets it convert names like Num into the appropriate object

### Subtype

A subtype is defined in terms of a parent type  and a constraint . Any constraints defined by the parent(s) will be checked first, followed by constraints defined by the subtype. A value must pass all of these checks to be valid for the subtype.
Typically, a subtype takes the parent's constraint and makes it more specific. 


### Coercion

A coercion lets you tell Moose to automatically convert one type to another.

{% highlight perl%}
    
use Moose::Util::TypeConstraints;

subtype 'ValidNumber' => as 'Num' =>
  where { warn "the number is $_, subtype checking"; $_ > 100 } =>
  message { 'Must be a num larger than 100' };

coerce 'ValidNumber' => from 'Num' => via { warn "the number is $_, coercing"; $_ + 100 };

package Foo;

use Moose;

has 'lucky_number' => (
    is     => 'rw',
    isa    => 'ValidNumber',
    coerce => 1,
);

package main;

my $foo = Foo->new( lucky_number => 12 );

print $foo->lucky_number();
print "\n";

__END__
the number is 12, subtype checking at type_coerce.pl line 4.
the number is 12, coercing at type_coerce.pl line 7.
the number is 112, subtype checking at type_coerce.pl line 4.
112
```

<p>the part after __END__ is  the result, let's see what happens.</p>


first,  when moose find a value of an attribute, it will check if it is pass the type validation.
that is what happens as in the first line of the result.

then moose find the value given can not pass validation and there is a coerce, so moose try to coerce.
as in the second line of the result.

after the coerce, moose will recheck if the value after coerce pass the type validation. if so, 
it continue happily. if not, the error message is thrown. (try to give it a number less than 0, 
see the error message yourself)
