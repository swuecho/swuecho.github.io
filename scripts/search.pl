
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use strict;
use warnings;

# (Change configuration variables as needed.)
my $path_to_index = '/home/hwu/data/lucy_play.index';

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

use DDP; 

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

