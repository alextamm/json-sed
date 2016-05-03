# json-sed

For want of a better name...

## Purpose

The script contained reads JSON from STDIN and manipulates it according to the parameters and prints
to STDOUT. Primary use case for me has been to delete extra stuff from JSON objects when doing CRUD operations with curl.

## Parameters

* [--pretty|-p]
  * Make the output human readable by adding whitespace
* [--reduce|-r &lt;key&gt;]
  * Remove everything else and move the value of &lt;key&gt; to the "root"
  * e.g with -r foo, this:
    
    {"foo":{"bar":1,"fubar":"string"}}
  * Will become this:
    
    {"bar":1,"fubar":"string"}
* [--delete|-d &lt;key&gt;]
  * Delete &lt;key&gt; and its value
* [--select|-s &lt;key&gt;]
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
