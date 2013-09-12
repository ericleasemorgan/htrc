#!/usr/bin/perl

# search-retrieve.pl - given a Solr query, return a zip stream of (no more than 100) HTRC texts and METS files
# example usage: ./search-retrieve.pl author:thoreau > thoreau.zip

# Eric Lease Morgan <emorgan@nd.edu>
# September 11, 2013 - first investigations


# configure
use constant ID     => "foo";
use constant SECRET => "bar";

# require
use strict;
require "./htrc-lib.pl";

# search and output results as zip stream
print &retrieve( ID, SECRET, [ &search( $ARGV[ 0 ] ) ] );

# done
exit;


