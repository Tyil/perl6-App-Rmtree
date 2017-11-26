#! /usr/bin/env perl6

use v6.c;

use App::Rmtree;
use File::Temp;
use Test;

my $dir = tempdir;

for ^3 {
	my ($filename, $handle) = tempfile;

	$handle.spurt: "";
}

ok $dir.IO.d, "Directory exists: $dir";
ok purge($dir), "purge($dir) returns True";
nok $dir.IO.d, "Directory is removed: $dir";

# vim: ft=perl6 noet
