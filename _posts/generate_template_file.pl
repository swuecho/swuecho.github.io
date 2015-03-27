use v5.20;
use POSIX qw(strftime);
if (not defined $ARGV[0]) {
    die "please give the tile"

}
my $date = strftime "%Y-%m-%d", localtime;
my $time = strftime "%Y-%m-%d %H:%M", localtime;
my $title = $ARGV[0] =~s[\s][\-]r;
my $fh_file = IO::File->new($date . '-' . $title . '.md', "w+");

my $template = <<TEMPLATE;
---
layout: post
title:  $title 
date:   $time 
categories: tech 
---

{% highlight bash %}

{% endhighlight %}

TEMPLATE

$fh_file->print($template);
