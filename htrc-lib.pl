# htrc-lib.pl - a rudimentary (read "brain-dead") library of Perl subroutines facilitating HTRC interactions

# Eric Lease Morgan <emorgan@nd.edu>
# September 11, 2013 - first cut


# configure
use constant SOLR      => 'http://sandbox.htrc.illinois.edu:9994/solr/meta/select?start=0&rows=100&q=';
use constant AUTHORIZE => "https://sandbox.htrc.illinois.edu:9443/oauth2endpoints/token?grant_type=client_credentials";
use constant DATAAPI   => 'https://sandbox.htrc.illinois.edu:25443/data-api/volumes';

# require
use JSON;
use LWP::UserAgent;
use strict;
use XML::XPath;


sub search {
	
	# initialize
	my $query = shift;
	
	# create a user-agent and search
	my $ua       = LWP::UserAgent->new;
	my $response = $ua->request( HTTP::Request->new( GET => SOLR . $query ) );
	
	# evaluate the response
	if ( $response->is_success ) { 
	
		my $xpath       = XML::XPath->new( xml => $response->content );
		my $nodes       = $xpath->find( "//str[\@name='id']" );
		my @identifiers = ();
		foreach my $node ( $nodes->get_nodelist ) { push @identifiers, $node->string_value }
		return @identifiers;
				
	}
	
	# error; bummer
	else { die $response->status_line, "\n" }

}


sub obtainOAuth2Token {

	# initialize
	my $clientID     = shift;
	my $clientSecret = shift;
	
	# create the user-agent and make a request
	my $request = HTTP::Request->new( POST => AUTHORIZE );
	$request->content_type( 'application/x-www-form-urlencoded' );
	$request->content( "client_id=$clientID&client_secret=$clientSecret" );
	my $ua = LWP::UserAgent->new;
	my $response = $ua->request( $request );

	# evaluate the response
	if ( $response->is_success ) {
	
		my $json = &decode_json( $response->content );
		return $$json{ 'access_token' };
	
	 }
	 
	# error; bummer
	else { die $response->status_line, "\n" }
	
}


sub retrieve {
	
	# initialize
	my $id          = shift;
	my $secret      = shift;
	my $identifiers = shift;
		
	# create the user-agent and make a request
	my $header = HTTP::Headers->new;
	$header->header( 'Content-Type'  => 'application/x-www-form-urlencoded' );
	$header->header( 'Authorization' => 'Bearer ' . &obtainOAuth2Token( $id, $secret ) );
	my $request   = HTTP::Request->new( 'POST', DATAAPI, $header );
	my $volumeIDs = join( '|', @$identifiers );
	$request->content( "volumeIDs=$volumeIDs&mets=true&concat=true" );
	my $ua = LWP::UserAgent->new;
	my $response = $ua->request( $request );

	# evaluate the response
	if ( $response->is_success ) { return $response->content }
	else { die $response->status_line, "\n" }

}


# return true or die
1;
