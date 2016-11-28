---
layout: post
title:  More Feeling about Perl6 
date:   2015-09-29 11:17 
categories: tech 
---

I tried Perl6 3 years ago and learn a lot from the book "Using Perl6". (when I think of the time, I am surprised that 3 years passed)

The book is very good, at least for me. It is the best book avaiable, offering an comprehensive introduction to the language.

Now, Due to there is a talk about Perl6 in the Orange County Perl Mongers, I want to refresh.


I am a bit frustrated by the fast change in Perl6. hopfully, this is the last major change. I am saying "GLR". 
The more I write Perl and Perl6, the more I feel auto flattern is probably not a good idea.
 It is very convient when it does not bite you. once you got bite, it is very hurt.

another complain is the language now is too big. Compared to other language, I think Perl is big too. 
However, I think Larry have extradinary power to expain thing in a very clear and practical way. 
I understand if you want to achieve big, you can not avoid the complex in it. This is natural law.
So language is big will be a feature when Larry explain it in details.


Of course, there are many good staff. the most impressive to me is the error message. 
It guide me, a perl 5 programer, to write correct code.

I am still in the way to get used to or relearn the ref vs %hash vs @array vs List. 

### Quiz and my code

The [quiz](http://www.metracom.com/august_challenge.html):

my code;

```perl

# run on This is perl6 version 2015.09-163-gcd8ce4e built on MoarVM version 2015.09-39-g1434283

use v6;
my $drawing_1 = set( ( 5,  27, 46, 55, 67 ).map: { ~$_ } );
my $drawing_2 = set( ( 14, 23, 32, 47, 62 ).map: { ~$_ } );
my $drawing_3 = set( ( 39, 45, 44, 42, 35 ).map: { ~$_ } );
my $drawing_4 = set( ( 69, 49, 1,  26, 10 ).map: { ~$_ } );
my $drawing_5 = set( ( 74, 61, 68, 73, 69 ).map: { ~$_ } );

my @drawings = $drawing_1, $drawing_2, $drawing_3, $drawing_4, $drawing_5;

my @names = (
    'line: 1 horizontal',
    'line: 2 horizontal',
    'line: 3 horizontal',
    'line: 4 horizontal',
    'line: 5 horizontal',
    'line: 1 vertical',
    'line: 2 vertical',
    'line: 3 vertical',
    'line: 4 vertical',
    'line: 5 vertical',
    'diagonally /',
    'diagonally \\'
);

my @lines = 'bingo.txt'.IO.lines;

my @games;

for @lines -> $line1, $line2, $line3, $line4, $line5, $player, $board, $blank_line {
      my @line1_arr = $line1.trim().split(' ');
      my @line2_arr = $line2.trim().split(' ');
      my @line3_arr = $line3.trim().split(' ');
      my @line4_arr = $line4.trim().split(' ');
      my @line5_arr = $line5.trim().split(' ');

      my @all_lines = @line1_arr, @line2_arr, @line3_arr, @line4_arr, @line5_arr;

      my @sets = 
        # horizional lines
        @line1_arr,
        @line2_arr,
        [ @line3_arr[ 0, 1, 3, 4 ] ],    # 2
        @line4_arr,
        @line5_arr,

        # vertical lines
        [ @all_lines.map: { $_[0] } ],    #why ( does not work
        [ @all_lines. map: { $_[1] } ],
        [ @all_lines[ 0, 1, 3, 4 ].map: { $_[2] } ],    # 7
        [ @all_lines.map: { $_[3] } ],
        [ @all_lines.map: { $_[4] } ],

        # diagnal lines
        [ @all_lines[0][4], @all_lines[1][3], @all_lines[3][1], @all_lines[4][0] ],
        [ @all_lines[0][0], @all_lines[1][1], @all_lines[3][3], @all_lines[4][4] ]
      ;

      my $all_set = set (@sets[0..4].flatmap: {|$_}); # all uniq elem in the borad

      for ^5 -> $j {
         if @drawings[$j] (&) $all_set >= 4 { ;
            # at least of 4 elems are in the total set
            for ^12 -> $i {
                my $set_i = set | @sets[$i];
                if $set_i (<=) @drawings[$j] {
                  my $result = ( $line1, $line2, $line3, $line4, $line5,   
                            $player, $board, @names[$i], $blank_line).join("\n");
                  @games[$j].push($result);
                 }
                }
            }
        }
}

# print result
for ^5 -> $g {
   say "Game " ~( $g + 1 );
   say @games[$g] . elems ~" winners\n";
   for @games[$g] { $_>>.say } ;
   say '------------------------------';
}

```

