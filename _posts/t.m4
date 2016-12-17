my $date = strftime "%Y-%m-%d",       localtime;
my $time = strftime "%Y-%m-%d %H:%M", localtime;
my $title = $ARGV[0] =~ s[\s][\-]rg;
my $fh_file = IO::File->new( $date . '-' . $title . '.md', "w+" );
my $template = <<TEMPLATE;
---
layout: post
title:  $title
date:   $time 
categories: tech 
---

```

```

