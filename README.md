FakeWeb
=======

* Author: geoff.jones@cyberis.co.uk
* Copyright: Cyberis Limited 2013
* License: GPLv3 (See LICENSE)

Very small implementation of fake web and DNS servers, written in Perl.

Description
-----------
A common technique when performing dynamic analysis of potential malware is to actually run it in an isolated virtual machine. I've written two scripts in Perl that serve as a fake DNS server and a basic web server.

The idea is simple, run both scripts/programs [as administrator/root] on the isolated analysis machine and point the machine's DNS resolution to 127.0.0.1. Any malware beaconing to a domain name rather than direct to an IP address will be shown in the output from fakedns.pl, whilst any HTTP requests on port 80 will be logged and shown by fakeweb.pl. For full capture, obviously run Wireshark and/or TCPDump alongside these programs.

Dependencies
------------
Perl, and nothing much else:
```perl
use Term::ANSIColor;
use IO::Socket;
```
FakeDNS also requires:
```perl
use Net::DNS::Nameserver;
```
Issues
------
Kindly report all issues via https://github.com/cyberisltd/FakeWeb/issues
