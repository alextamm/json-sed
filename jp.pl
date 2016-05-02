#!/usr/bin/env perl

use Hash::Util;
use JSON::XS;
use Data::Dumper;
use Getopt::Long;
use 5.012;
use Carp;
use strict;
use warnings;
use Storable qw(dclone);
use Data::Diver qw(DiveRef);

Getopt::Long::Configure('no_ignore_case');

my $j= JSON::XS->new();

my $pretty;
my $reduce;
my @select;
my @delete;
GetOptions(
    "pretty|p"   => \$pretty,
    "reduce|r=s" => \$reduce,
    "select|s=s" => \@select,
    "delete|d=s" => \@delete,
);

local $/;
my $s=<>;
exit unless $s;

my $orig = $j->decode($s);
my $new = dclone($orig);
my @objects;

if( ref $new eq 'ARRAY' ) {
    @objects = @$new;
}
elsif( ref $new eq 'HASH') {
    push @objects, $new;
}
for my $h (@objects) {
    if ( $reduce ) {
        $h = $h->{$reduce};
    }

    for my $del_key (@delete) {
        my @path = split(/\./,$del_key);
        my $last_key = pop @path;
        my $ref = ${ DiveRef($h, @path) };
        delete $ref->{ $last_key};
    }

    if ( $pretty ) {
        $j->pretty(1);
        $j->space_before(0);
    }
}
print $j->encode($new);
