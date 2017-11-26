#! /usr/bin/env false

use v6.c;

unit module App::Rmtree;

multi sub purge (
	Str:D $path where { .IO.d },
	Str:D :@sacred-extensions,
	--> Bool
) is export {
	chdir $path;

	for $path.IO.dir -> $element {
		return False unless purge($element.IO.absolute, :@sacred-extensions);
	}

	$path.IO.rmdir;
}

multi sub purge (
	Str:D $path where { .IO.d },
	--> Bool
) is export {
	chdir $path;

	for $path.IO.dir -> $element {
		return False unless purge($element.IO.absolute);
	}

	$path.IO.rmdir;
}

multi sub purge (
	Str:D $path,
	Str:D :@sacred-extensions,
	--> Bool
) is export {
	# Check for sacred items
	for @sacred-extensions -> $extension {
		my Int $parts = $extension.indices(".") + 1;

		return False if $path.IO.extension(:$parts) eq $extension;
	}

	purge($path);
}

multi sub purge (
	Str:D $path,
	--> Bool
) is export {
	$path.IO.unlink;
}

# vim: ft=perl6 noet
