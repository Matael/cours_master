#! /usr/bin/env perl -w
#
# fileconverter.pl
#
# Copyright © 2016 Mathieu Gaborit (matael) <mathieu@matael.org>
#
#
# Distributed under WTFPL terms
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO.
#

use strict;
use warnings;

my $filename = $ARGV[0];
my $out_filename = $filename;
$out_filename =~ s/\.csv/_matlab.csv/;

open(DF, $filename) or die('Unable to open file, you asshole!');
open(OUT, '>> '.$out_filename) or die('Unable to open file, you asshole!');

my $frame = 0;
my $framesize = 0;
my $vcount = 0;

while (my $l = <DF>) {

	if ($l =~ /^#Spec,\w+,(\d+),.*/) {
		if ($frame==1) {
			$framesize = $1;
		} else {
			die("Inconsistent framesize !") if ($1!=$framesize);
		}
		$vcount = 0;
	} elsif ($l =~ /^#Frame,(\d+),.*/) {
		die("You missed something guy.") if ($1 != $frame+1);
		$frame = $1;
		print "Reading Frame ".$frame."\n";
		print OUT "\n";
	} elsif ($l =~ /^([-.\d]+)$/) {
		print OUT $1."\t";
	}
}

