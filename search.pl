#!/usr/bin/perl

# search.pl - given a Solr query, return a list of (no more than 100) HathiTrust Research Center identifiers
# example usage: ./search.pl 'publishDate:1884 AND author:Dickens'

# Eric Lease Morgan <emorgan@nd.edu>
# September 11, 2013 - first investigations; wanting to use WebService::Solr, but...


# require
use strict;
require "./htrc-lib.pl";

# search and output results
foreach ( &search( $ARGV[ 0 ] ) ) { print "$_\n" }

# done
exit;


