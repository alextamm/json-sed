# json-sed

For want of a better name...

`jsed` for short. Suggest to use a symbolic link `jsed` to `jsed.pl`.

## Description

Reads JSON from STDIN, manipulates it and prints the resulting JSON to STDOUT. Primary use case
for me has been to delete extra stuff from JSON objects when doing CRUD operations with curl.

## usage

  `jsed.pl [--pretty|-p] [--reduce|-r <key>] [--delete|-d <key>] [--select|-s <key>]`

## Parameters

* `[--pretty|-p]`
  * Make the output human readable by adding whitespace
* `[--reduce|-r <key>]`
  * Remove everything else and move the value of `<key>` to the "root"
  * e.g with `-r foo`, this:
    
    `{"foo":{"bar":1,"fubar":"string"}}`
  * Will become this:
    
    `{"bar":1,"fubar":"string"}`
* `[--delete|-d <key>]`
  * Delete <key> and its value
* `[--select|-s <key>]`
  * Does nothing yet (TODO)

## Requirements

* Perl 5.10 or greater
* Perl modules:
  * Hash::Util
  * JSON::XS
  * Data::Dumper
  * Getopt::Long
  * Carp
  * Storable
  * Data::Diver
