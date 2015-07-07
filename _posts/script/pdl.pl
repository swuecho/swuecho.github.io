use v5.20;
use PDL;
# basic matrix calculation
# see PDL::Primitive

my $v1 = pdl([42,52,48,58]);
say $v1;
my $v2 = pdl( [4,5,4,3]);
say $v2;
my $x  = pdl([$v1, $v2]);
say $x;
# ($mean,$prms,$median,$min,$max,$adev,$rms) = statsover($piddle, $weights);
my @statsover = statsover($x);
say $_ for @statsover;
# ($mean,$prms,$median,$min,$max,$adev,$rms) = stats($piddle,[$weights]);
my @stats = stats($x);
say $_ for @stats;



