---
layout: post
title:  Perl and Pipe
date:   2020-12-18 10:48 
categories: tech 
---
# The Problem

echo $PATH output is too long. I want to see it line by line. 


# First Attempt 

```sh
➜  ~ echo $PATH | perl -E 'say $ARGV[0]'

➜  ~ echo $PATH | perl -E 'say'         

```

why this does not work?

> because piped content is passed in as `<STDIN>`


# Second Attempt

pipe as STDIN 

    echo $PATH | perl -E 'say while <STDIN>'
    echo $PATH | perl -E 'while (<STDIN>) { say for split /:/}' 

# The Right Way 

    echo $PATH | perl -nE 'say for split /:/'

# Reference


> -n causes Perl to assume the following loop around your program, which
> 
> makes it iterate over filename arguments somewhat like _sed -n_ or
> 
> _awk_:
> 
> LINE:
> 
> while (<>) {
> 
> ... # your program goes here
> 
> }
> 
> Note that the lines are not printed by default. See "-p" to have
> 
> lines printed. If a file named by an argument cannot be opened for
> 
> some reason, Perl warns you about it and moves on to the next file.
> 
> Also note that "<>" passes command line arguments to "open" in
> 
> perlfunc, which doesn't necessarily interpret them as file names.
> 
> See perlop for possible security implications.

PS:

## Another Solution with help from xargs

args to make pipe out to argv[0]

    echo $PATH | xargs perl -E 'say for split /:/, $ARGV[0]'

Of Course, use perl directly with pipe works

    perl -E 'say for split /:/ , $ENV{"PATH"}'


