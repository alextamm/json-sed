#!/usr/bin/env perl

use Hash::Util;
use JSON::PP;
use Data::Dumper;
use Getopt::Long;
use 5.012;
use Carp;
use strict;
use warnings;
use Storable qw(dclone);
use Data::Diver qw(DiveRef);

Getopt::Long::Configure('no_ignore_case');

my $j= JSON::PP->new();

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

# exit 0;
# slurp
local $/;
my $s=<>;
exit unless $s;

my $orig = $j->decode($s);

my $new = dclone($orig);

if( $reduce ) {
    $new = $new->{$reduce};
}

for my $del_key (@delete) {
    my @path = split(/\./,$del_key);
    my $last_key = pop @path;
    my $ref = ${ DiveRef($new, @path) };
    #print Dumper \@path;
    #print $last_key;
    #print Dumper $ref;
    delete $ref->{ $last_key};
}
#exit 0;
#print Dumper \$new;
if( $pretty ) {
    $j->pretty(1);
    $j->space_before(0);
}
print $j->encode($new);
