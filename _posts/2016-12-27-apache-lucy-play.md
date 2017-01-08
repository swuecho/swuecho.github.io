---
layout: post
title:  apache lucy play 
date:   2016-12-27 14:33 
categories: tech 
---

## Install

install can not be easier 

```
cpanm Lucy
```

## Use

The official tutorial is a bit complex. It is kind of a showcase.
So I trim it a bit.


To use Lucy, there are two basic steps.

1. Create index
2. Search 


```perl
use v5.10;

# (Change configuration variables as needed.)
my $path_to_index = '/home/hwu/data/lucy_play.index';
my $uscon_source  = '/home/hwu/app/apache-lucy-0.6.1/common/sample/us_constitution';

use File::Spec::Functions qw( catfile );
use Lucy::Plan::Schema;
use Lucy::Plan::FullTextType;
use Lucy::Analysis::EasyAnalyzer;
use Lucy::Index::Indexer;

# Create Schema.
my $schema = Lucy::Plan::Schema->new;
my $easyanalyzer = Lucy::Analysis::EasyAnalyzer->new(
    language => 'en',
);
my $title_type = Lucy::Plan::FullTextType->new( 
    analyzer => $easyanalyzer,
);
my $content_type = Lucy::Plan::FullTextType->new(
    analyzer      => $easyanalyzer,
    highlightable => 1,
);
my $url_type = Lucy::Plan::StringType->new( indexed => 0, );
my $cat_type = Lucy::Plan::StringType->new( stored => 0, );
$schema->spec_field( name => 'title',    type => $title_type );
$schema->spec_field( name => 'content',  type => $content_type );
$schema->spec_field( name => 'url',      type => $url_type );
$schema->spec_field( name => 'category', type => $cat_type );

# Create an Indexer object.
my $indexer = Lucy::Index::Indexer->new(
    index    => $path_to_index,
    schema   => $schema,
    create   => 1,
    truncate => 1,
);

# Collect names of source files.
opendir( my $dh, $uscon_source )
    or die "Couldn't opendir '$uscon_source': $!";
my @filenames = grep { $_ =~ /\.txt/ } readdir $dh;

# Iterate over list of source files.
for my $filename (@filenames) {
    print "Indexing $filename\n";
    my $doc = parse_file($filename);
    $indexer->add_doc($doc);
}

# Finalize the index and print a confirmation message.
$indexer->commit;
print "Finished.\n";

# Parse a file from our US Constitution collection and return a hashref with
# the fields title, body, url, and category.
sub parse_file {
    my $filename = shift;
    my $filepath = catfile( $uscon_source, $filename );
    open( my $fh, '<', $filepath ) or die "Can't open '$filepath': $!";
    my $text = do { local $/; <$fh> };    # slurp file content
    $text =~ /\A(.+?)^\s+(.*)/ms 
        or die "Can't extract title/bodytext from '$filepath'";
    my $title    = $1;
    my $bodytext = $2;
    my $category
        = $filename =~ /art/      ? 'article'
        : $filename =~ /amend/    ? 'amendment'
        : $filename =~ /preamble/ ? 'preamble'
        :                           die "Can't derive category for $filename";
    return {
        title    => $title,
        content  => $bodytext,
        url      => "/us_constitution/$filename",
        category => $category,
    };
}
```

search (use the index)


```perl
use v5.10;

my $path_to_index = '/home/hwu/data/lucy_play.index';

use DDP; 
use List::Util qw( max min );
use POSIX qw( ceil );
use Encode qw( decode );
use Lucy::Search::IndexSearcher;
use Lucy::Highlight::Highlighter;
use Lucy::Search::QueryParser;
use Lucy::Search::TermQuery;
use Lucy::Search::ANDQuery;


# Create an IndexSearcher and a QueryParser.
my $searcher = Lucy::Search::IndexSearcher->new( 
    index => $path_to_index,
);
my $qparser = Lucy::Search::QueryParser->new( 
    schema => $searcher->get_schema,
);


p $searcher->get_schema->dump;

# Build up a Query.
my $q = 'power';
my $query = $qparser->parse($q);

my $category = '';
if ($category) {
    my $category_query = Lucy::Search::TermQuery->new(
        field => 'category', 
        term  => $category,
    );
    $query = Lucy::Search::ANDQuery->new(
        children => [ $query, $category_query ]
    );
}


my $offset = 0;
my $page_size = 10;
# Execute the Query and get a Hits object.
my $hits = $searcher->hits(
    query      => $query,
    offset     => $offset,
    num_wanted => $page_size,
);
my $hit_count = $hits->total_hits;

# Arrange for highlighted excerpts to be created.
my $highlighter = Lucy::Highlight::Highlighter->new(
    searcher => $searcher,
    query    => $q,
    field    => 'content'
);

# Create result list.
my $report = '';
while ( my $hit = $hits->next ) {
    my $score   = sprintf( "%0.3f", $hit->get_score );
    my $excerpt = $highlighter->create_excerpt($hit);
    p $excerpt;
    p $hit->dump;
}
```

the scripts can be downloaded at

https://raw.githubusercontent.com/swuecho/swuecho.github.io/master/scripts/indexer.pl
https://raw.githubusercontent.com/swuecho/swuecho.github.io/master/scripts/search.pl


