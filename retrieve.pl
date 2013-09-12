#!/usr/bin/perl

# retrieve.pl - given a list of HTRC identifiers, return a zip stream of text and xml
# example usage: ./retrieve.pl loc.ark:/13960/t9765zm02  > output.zip

# Eric Lease Morgan <emorgan@nd.edu>
# September 11, 2013 - first investigations


# configure
use constant ID     => "foo";
use constant SECRET => "bar";

# require
use strict;
require "./htrc-lib.pl";

# do the work
print &retrieve( ID, SECRET, [ @ARGV ] );

# done
exit;


