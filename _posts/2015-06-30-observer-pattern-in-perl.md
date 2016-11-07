---
layout: post
title:  observer pattern in perl 
date:   2015-06-30 13:16 
categories: tech 
---

# Obverver Pattern

https://en.wikipedia.org/wiki/Observer_pattern

## implement the example in Perl

{% highlight bash %}

use Std;    #for signature and postfix deref

package Observable {
    use Moose;
    use Std;

    has 'observers' => ( is => 'rw', default => sub { [] } );

    #TODO: this can be delegated
    sub register_observer($self, $observer) {
        push $self->observers->@*, $observer;
    }

    sub notify_observers($self, @rest) {
        $_->notify(@rest) for $self->observers->@*;
    }
}

package Observer1 {
    use Moose;
    use Std;

    sub register($self, $observable) {
        $observable->register_observer($self);
    }

    sub notify {
        my $self    = shift;
        my $message = shift;
        say $message;
    }
}

package Observer2 {
    use Moose;
    use Std;

    sub register($self, $observable) {
        $observable->register_observer($self);
    }

    sub notify {
        my $self    = shift;
        my $message = shift;
        say $message;
    }
}

my $subject = Observable->new();

my $observer1 = Observer1->new->register($subject);
my $observer2 = Observer2->new->register($subject);

$subject->notify_observers('test');

```



## emulate the EventEmiter in Node js

{% highlight bash %}

use Std;

package Obserable {
    use Moose::Role;
    use Std;

    has 'events' => ( is => 'rw', default => sub { +{} } );

    sub on($self, $name, $cb) {
        $self->events->{$name} = [] if not defined $self->events->{$name};
        push $self->events->{$name}->@*, $cb;
    }

    sub emit($self, $name, @rest ) {
        if ( my $cb_aref = $self->events->{$name} ) {
            $_->(@rest) for @$cb_aref;
        }
    }

}

package SimpleEE {
    use Moose;
    with 'Obserable';
}

my $emitter = SimpleEE->new();

$emitter->on( 'greet', sub ($name) { say( 'Hello, ' . $name . '!' ); } );
$emitter->on( 'greet', sub ($name) { say( 'World, ' . $name . '!' ); } );

$emitter->emit( 'greet', $_ ) for qw( foo bar baz);
```

