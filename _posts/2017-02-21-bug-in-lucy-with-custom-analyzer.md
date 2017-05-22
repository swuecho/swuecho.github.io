---
layout: post
title:  bug in lucy with custom analyzer 
date:   2017-02-21 14:01 
categories: tech 
---
## PART I

Few days ago, I was trying to search some chinese doc with Lucy.
I have to write chinese analyzer because of not built in chinese support.

However, it is not going well. 

```perl
#!/usr/local/bin/perl
package MyAnalyzer {
use v5.10;
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
    my @tokens = (['a', 0,1], ['b', 1,2] );
    $inversion->append(
       Lucy::Analysis::Token->new(text =>$_->[0],
                                  start_offset=> $_->[1] ,
                                  end_offset=>$_->[2] 
        )
        
    ) for @tokens;
    return $inversion;
}

1;

}

package main;
use DBI;
use File::Spec::Functions qw( catfile );

use Lucy::Plan::Schema;
use Lucy::Plan::FullTextType;
use Lucy::Index::Indexer;


my $path_to_index = '/tmp/test.index';

# Create Schema.
my $schema = Lucy::Plan::Schema->new;

my $my_analyzer= MyAnalyzer->new();

my $raw_type = Lucy::Plan::FullTextType->new(
        analyzer => $my_analyzer,
);

$schema->spec_field( name => 'body',  type => $raw_type);
use DDP; p $schema->dump;
# Create an Indexer object.
my $indexer = Lucy::Index::Indexer->new(
    index    => $path_to_index,
    schema   => $schema,
    create   => 1,
#    truncate => 1,
);


my $doc = { body => 'test' }; 
$indexer->add_doc($doc);

$indexer->commit;

print "Finished.\n";

```
run above program twice, you will get 

```
'body' assigned conflicting FieldType
        LUCY_Schema_Spec_Field_IMP at cfcore/Lucy/Plan/Schema.c line 124
        at /home/hwu/perl5/lib/perl5/x86_64-linux-gnu-thread-multi/Lucy.pm line 118.
        Lucy::Index::Indexer::new('Lucy::Index::Indexer', 'index', '/tmp/test.index', 'schema', 'Lucy::Plan::Schema=SCALAR(0x6d4750)', 'create', 1) called at test_index.pl line 58
```

## PART II

