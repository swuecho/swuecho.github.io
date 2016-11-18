---
layout: post
title:  a simple moose role to deserialize moose object 
date:   2015-06-08 22:44 
categories: tech 
---
### the moose role

```{bash}
package TOJSON;
use Moose::Role;

sub TO_JSON {
    my $self = shift;
    my %href =
      map { $_->has_value($self) ? ( $_->name => $_->get_value($self) ) : () }
      $self->meta->get_all_attributes;
    return \%href;

}

1;

```

### use the role

```{bash}

package Point {

    use Moose;
    use TOJSON;

    with 'TOJSON';

    has 'x' => ( isa => 'Int', is => 'rw', required => 1 );
    has 'y' => ( isa => 'Int', is => 'rw', required => 1 );

}

use DDP;

my $p = Point->new( { new => 1, x => 1, y => 2 } );
p $p->TO_JSON;

```

