#!/usr/bin/env perl

use Hash::Util;
use JSON::XS;
use Data::Dumper;
use Getopt::Long;
use 5.010;
use Carp;
use strict;
use warnings;
use Storable qw(dclone);
use Data::Diver qw(DiveRef);

my $pretty;
my $reduce;
my @select;
my @delete;

sub manipulate {
    my ($ref )= @_;
    if( ref $ref eq 'ARRAY' ) {
        for my $item ( @$ref ) {
            manipulate($item);
        }
    }
    elsif( ref $ref eq 'HASH' ) {
        if ( $reduce ) {
            %$ref = %{ $ref->{$reduce} };
        }

        for my $del_key (@delete) {
            my @path = split(/\./,$del_key);
            my $last_key = pop @path;
            my $deep_ref = ${ DiveRef($ref, @path) };
            if( ref $deep_ref eq 'HASH' ) {
                delete $deep_ref->{ $last_key };
            }
            elsif( ref $deep_ref eq 'ARRAY' ) {
                if( $last_key =~ /\D/ ) {
                    croak( join('.', @path) . " is an array, but $last_key is not a number/");
                }
                splice( @$deep_ref, $last_key, 1);
            }
        }
    }
}
Getopt::Long::Configure('no_ignore_case');
GetOptions(
    "pretty|p"   => \$pretty,
    "reduce|r=s" => \$reduce,
    "select|s=s" => \@select,
    "delete|d=s" => \@delete,
);

local $/;
my $s=<>;
exit unless $s;
my $j= JSON::XS->new();

my $orig = $j->decode($s);
my $new = dclone($orig);
my @objects;

manipulate($new);

if ( $pretty ) {
    $j->pretty(1);
    $j->space_before(0);
}

print $j->encode($new);
