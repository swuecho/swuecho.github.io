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
