#!/usr/local/bin/perl
use strict;
use warnings;

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

