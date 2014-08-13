use v5.20;
use POSIX qw(strftime);
my $date = strftime "%Y-%m-%d", localtime;
my $time = strftime "%Y-%m-%d %H:%M", localtime;

my $fh_file = IO::File->new($date . '-' .$ARGV[0] . '.md', "w+");

my $template = <<TEMPLATE;
---
layout: post
title:  todo  
date:   $time 
categories: tech 
---

{% highlight bash %}

{% endhighlight %}

TEMPLATE

$fh_file->print($template);
