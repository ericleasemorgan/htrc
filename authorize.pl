#!/usr/bin/perl

# authorize.pl - given a client id and secret, return an HTRC authorization token

# Eric Lease Morgan <emorgan@nd.edu>
# September 9, 2013 - hacked at "HathiTrust Day"
# September 11, 2013 - "required" the library


# configure
use constant ID       => "foo";
use constant SECRET   => "bar";

# require
use strict;
require "./htrc-lib.pl";

# output an authorization token
print &obtainOAuth2Token( ID, SECRET ), "\n";

# done
exit;

