

README.md

This is the README file for a tiny library of Perl subroutines to be
used against the HathiTrust Research Center (HTRC) application
programmer interfaces (API). This distribution ought to contain a number
of files, each briefly described below:

  * README.md - this file
  * LICENSE - a copy of the GNU Public License
  * htrc-lib.pl - our raison d'être; more below
  * search.pl - given a Solr query, return a list of no more than
    100 HTRC identifiers
  * authorize.pl - given a client identifier and secret, return an
    authorization token
  * retrieve.pl - given a list of HTRC identifiers, return a zip
    stream of no more than 100 text and METS files
  * search-retrieve.pl - given a Solr query, return a zip stream of
    no more than 100 texts and METS files

The file doing the heavy lifting is htrc-lib.pl. It contains only three
subroutines:

  1. search - given a Solr query, returns a list of no more than
     100 HTRC identifiers
  2. obtainOAuth2Token - given a client ID and secret (supplied by
     the HTRC), return an authorization token, and this token is
     expected to be included in the HTTP header of any HTRC Data API
     request.
  3. retrieve - given a client ID, secret, and list of HTRC
     identifiers, return a zip stream of no more than 100 HTRC text
     and METS files

The library is configured at the beginning of the file with three
constants:

  1. SOLR - a stub URL pointing to the location of the HTRC Solr
     index, and in this configuration you can change the number of
     search results that will be returned
  2. AUTHORIZE - the URL pointing to the authorization engine
  3. DATAAPI - the URL pointing to the HTRC Data API, specifically
     the API to get volumes

The other .pl files in this distribution are the simplest of scripts
demonstrating how to use the library.

Be forewarned. The library does very little error checking, nor is there
any more documentation beyond what you are reading here.

Before you will be able to use the obtainOAuth2Token and retrieve
subroutines, you will need to acquire a client identifier and secret
from the HTRC. These are required in order for the Center to track who
is using their services.

The home page for the HTRC is http://www.hathitrust.org/htrc. From there
you ought to be able to read more information about the Center and their
supported APIs.

This software is distributed under the GNU Public License.

Finally, here is a suggestion of how to use this library:

  1. Use your Web browser to search the HTRC for content --
     https://htrc2.pti.indiana.edu/HTRC-UI-Portal2/ or
     https://sandbox.htrc.illinois.edu:8443/blacklight -- ultimately
     generating a list of HTRC identifiers.
  2. Programmatically feed the list of identifiers to the retrieve
     subroutine.
  3. "Inflate" the zip stream into its constituent text and METS
     files.
  4. Do analysis against the result.

I'm tired. That is enough for now. Enjoy.

--
Eric Lease Morgan <emorgan@nd.edu>
September 12, 2013