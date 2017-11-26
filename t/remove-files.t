#! /usr/bin/env perl6

use v6.c;

use App::Rmtree;
use File::Temp;
use Test;

my Str @files;

for ^10 -> $file {
	my ($filename, $handle) = tempfile;
	@files.append: $filename;
}

plan @files.elems × 3;

for @files -> $file {
	ok $file.IO.f, "File exists: $file";
	ok purge($file), "purge($file) returns True";
	nok $file.IO.f, "File is removed: $file";
}

# vim: ft=perl6 noet
