package Plugins::PoslouchejRadia::Plugin;

# Plugin Poslouchej radia
# Copyright (C) 2021 Mario Babinec (mr.babinec@gmail.com)
# Released under GPLv2

use strict;
use warnings;

use base qw(Slim::Plugin::OPMLBased);

use Data::Dumper;
use Encode qw(encode decode);
use Slim::Utils::Strings qw(string cstring);
use Slim::Utils::Prefs;
use Slim::Utils::Log;

use Plugins::PoslouchejRadia::API;

use constant ICON_PATH => 'plugins/PoslouchejRadia/html/images/icon.png';

my	$log = Slim::Utils::Log->addLogCategory({
	'category'     => 'plugin.poslouchej.radia',
	'defaultLevel' => 'DEBUG',
	'description'  => 'PLUGIN_POSLOUCHEJ_RADIA',
});


sub initPlugin {
	my $class = shift;

	$log->debug("Poslouchej_radia initPlugin");

	$class->SUPER::initPlugin(
		feed   => \&toplevel,
		tag    => 'PoslouchejRadio',
		menu   => 'radios',
		is_app => 1,
		weight => 10,
	);

}

sub getDisplayName { 'PLUGIN_POSLOUCHEJ_RADIA' }

sub toplevel {
	my ($client, $callback, $args) = @_;
	$log->debug("PoslouchejRadio toplevel ");
	$callback->([
    { name => cstring($client, 'PLUGIN_STATES'), type => 'url', url => \&menuHandler, icon => ICON_PATH },
		{ name => cstring($client, 'PLUGIN_TOPSTATIONS_SK'), type => 'url', url => \&topStationsHandler, icon => ICON_PATH },
    { name => cstring($client, 'PLUGIN_TOPSTATIONS_CZ'), type => 'url', url => \&topCZStationsHandler, icon => ICON_PATH },
		{ name => cstring($client, 'PLUGIN_ROCK'), type => 'url', url => \&rockHandler, icon => ICON_PATH },
	]);
}

sub menuHandler {
	my ($client, $cb, $args, $params) = @_;
	$log->debug("PoslouchejRadio menuHandler");
	my $items = [];
	push @$items, {
		name => cstring($client, 'PLUGIN_SK'),
		type => 'url',
		url  => \&skStationsHandler,
    icon => ICON_PATH,
	};
	push @$items, {
		name => cstring($client, 'PLUGIN_CZ'),
		type => 'url',
		url  => \&czStationsHandler,
    icon => ICON_PATH,
	};
	$cb->( $items );

}

sub skStationsHandler {
	my ($client, $cb, $args, $params) = @_;
	$log->debug("PoslouchejRadio topStationsHandler");
	Plugins::PoslouchejRadia::API->skStations( sub {
		my $stations = shift;
		getStations($stations, $cb);
	});
}

sub czStationsHandler {
	my ($client, $cb, $args, $params) = @_;
	$log->debug("PoslouchejRadio topStationsHandler");
	Plugins::PoslouchejRadia::API->czStations( sub {
		my $stations = shift;
		getStations($stations, $cb);
	});
}

sub topCZStationsHandler {
	my ($client, $cb, $args, $params) = @_;
	$log->debug("PoslouchejRadio topStationsHandler");
	Plugins::PoslouchejRadia::API->topCzStations( sub {
		my $stations = shift;
		getStations($stations, $cb);
	});
}

sub topStationsHandler {
	my ($client, $cb, $args, $params) = @_;
	$log->debug("PoslouchejRadio topStationsHandler");
	Plugins::PoslouchejRadia::API->topSkStations( sub {
		my $stations = shift;
		getStations($stations, $cb);
	});
}

sub rockHandler {
	my ($client, $cb, $args, $params) = @_;
	$log->debug("PoslouchejRadio topStationsHandler");
	Plugins::PoslouchejRadia::API->rockStations( sub {
		my $stations = shift;
		getStations($stations, $cb);
	});
}

sub getStations {
	my ($stations, $cb) = @_;
	$log->debug("PoslouchejRadio getStations");
	my @stations = @{ $stations };
	my $station = [];
	my $items = [];
	for $station ( @stations ) {
		push @$items, {
			name 		=> $station->{title},
			type 		=> 'audio',
			url  		=> $station->{url},
      icon    => $station->{img},
		};
	}
	$cb->( $items );
}
1;
