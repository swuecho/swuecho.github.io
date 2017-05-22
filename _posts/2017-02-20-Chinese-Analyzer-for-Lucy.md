---
layout: post
title:  Chinese Analyzer for Lucy 
date:   2017-02-20 21:20 
categories: tech 
---


## Chinese Analyzer

the abstract method is transform. it transform inversion to inversion.

I think if the analyzer is not the first one. have to transfrom from text to inversion first.

so the transform_text is the one I actually implemented.

turn out it works rather well.


```perl
package ChineseAnalyzer;
use Jieba;
use v5.10;
use Encode qw(decode_utf8);
use base qw( Lucy::Analysis::Analyzer );

sub new {
    my $self = shift->SUPER::new;
    return $self;
}

sub transform {
    my ($self, $inversion)= @_;
    return $inversion;
}

sub transform_text {
    my ($self, $text) = @_;
    my $inversion = Lucy::Analysis::Inversion->new;
    my @tokens = Jieba::jieba_tokenize(decode_utf8($text));
    $inversion->append(
       Lucy::Analysis::Token->new(text =>$_->[0],
                                  start_offset=> $_->[1] ,
                                  end_offset=>$_->[2] 
        )
        
    ) for @tokens;
    return $inversion;
}

1;
```


## use Inline::Python to provide the tokenize function

```perl
package Jieba;
use v5.10;
use parent 'Exporter';
our @EXPORT = qw/jieba_tokenize test/;

sub jieba_tokenize {
    jieba_tokenize_python(shift);
}

# TODO: 
#result = jieba.tokenize(u'永和服装饰品有限公司', mode='search')
use Inline Python => <<'END_OF_PYTHON_CODE';
from jieba import tokenize

def jieba_tokenize_python(text):
    seg_list = tokenize(text, mode='search')
    return(list(seg_list))

END_OF_PYTHON_CODE

1;
```


