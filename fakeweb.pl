#!/usr/bin/perl

# Basic web server responding with a small page and logging the request to STDOUT

# Copyright(C) 2013 Cyberis Limited
# Author: geoff.jones@cyberis.co.uk

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;
use Term::ANSIColor;
use IO::Socket;


# Create socket (needs root of course)
my $sock = new IO::Socket::INET (
	LocalHost => '127.0.0.1',
	LocalPort => '80',
	Proto => 'tcp',
	Listen => 10,
	ReuseAddr => 1,
) || die "Could not create socket: $!\n";

# Prepate the response
my @httpresponse = <DATA>;

# Start listening
print &httpLabel . "Listening...\n\n";

my $client;
while ($client = $sock->accept()) {

	next if my $pid = fork;
	die "Error forking child process - $!\n" unless defined $pid;

	my @httprequest;

	my $line = <$client>;

	while (defined ($line) && $line ne "\r\n") {
           	push (@httprequest,$line);
		$line = <$client>;
	}
	
	# Print the request
	print &httpLabel;
	foreach (@httprequest) {
		print $_;
	}
	
	# Print the response
	foreach (@httpresponse) {
		print $client $_;
	}
	print "\n";

	# Clost the client connection
	$client->close;
	exit( fork );
}
continue
{
	close($client);
	kill CHLD => -$$;
}

sub httpLabel {
	print color 'green';
	print "[HTTP]\n";
	print color 'reset';
	return "";
}

__DATA__
HTTP/1.1 200 OK
Server: Fake-dns-web
Content-Type: text/html


<HTML>
<BODY>
<PRE>
Request received and processed.
</PRE>
</BODY>
</HTML>


