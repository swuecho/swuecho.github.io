#!/home/hwu/.plenv/shims/perl
use v5.18;
use POSIX qw(strftime);
if ( not defined $ARGV[0] ) {
    die "ERROR: please give the tile"
}
if ( $#ARGV > 0 ) {
    die "ERROR: only one argv is accept"

}
my $date = strftime "%Y-%m-%d",       localtime;
my $time = strftime "%Y-%m-%d %H:%M", localtime;
my $title = $ARGV[0] =~ s[\s][\-]rg;
my $fh_file = IO::File->new( $date . '-' . $title . '.md', "w+" );
my $template = <<TEMPLATE;
---
layout: post
title:  $ARGV[0] 
date:   $time 
categories: tech 
---

```

```

TEMPLATE

$fh_file->print($template);
