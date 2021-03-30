package Plugins::PoslouchejRadia::API;

use strict;

use JSON::XS::VersionOneAndTwo;
use Slim::Utils::Log;
use Slim::Utils::Prefs;
use constant API_URL => 'https://moj-dennik.eu/api/';

my $prefs = preferences('plugin.poslouchej.radia');
my $log   = logger('plugin.poslouchej.radia');

sub skStations {
	my ( $class, $cb, $args ) = @_;
	$log->debug("get skStations");
	my $url = API_URL . "getSK";
	Slim::Networking::SimpleAsyncHTTP->new(
		sub {
			my $response = shift;
			my $result = eval { decode_json($response->content) };
			$result ||= {};
			$cb->($result->{stanice});
		},
	)->post($url,'Content-Type' => 'application/json','Content-Length' => 0);
}


sub czStations {
	my ( $class, $cb, $args ) = @_;
	$log->debug("get czStations");
	my $url = API_URL . "getCZ";
	Slim::Networking::SimpleAsyncHTTP->new(
		sub {
			my $response = shift;
			my $result = eval { decode_json($response->content) };
			$result ||= {};
			$cb->($result->{stanice});
		},
	)->post($url,'Content-Type' => 'application/json','Content-Length' => 0);
}

sub topSkStations {
	my ( $class, $cb, $args ) = @_;
	$log->debug("get topSkStations");
	my $url = API_URL . "getTopSK";
	Slim::Networking::SimpleAsyncHTTP->new(
		sub {
			my $response = shift;
			my $result = eval { decode_json($response->content) };
			$result ||= {};
			$cb->($result->{stanice});
		},
	)->post($url,'Content-Type' => 'application/json','Content-Length' => 0);
}

sub topCzStations {
	my ( $class, $cb, $args ) = @_;
	$log->debug("get topCzStations");
	my $url = API_URL . "getTopCZ";
	Slim::Networking::SimpleAsyncHTTP->new(
		sub {
			my $response = shift;
			my $result = eval { decode_json($response->content) };
			$result ||= {};
			$cb->($result->{stanice});
		},
	)->post($url,'Content-Type' => 'application/json','Content-Length' => 0);
}

sub rockStations {
	my ( $class, $cb, $args ) = @_;
	$log->debug("get topCzStations");
	my $url = API_URL . "getRock";
	Slim::Networking::SimpleAsyncHTTP->new(
		sub {
			my $response = shift;
			my $result = eval { decode_json($response->content) };
			$result ||= {};
			$cb->($result->{stanice});
		},
	)->post($url,'Content-Type' => 'application/json','Content-Length' => 0);
}
1;
