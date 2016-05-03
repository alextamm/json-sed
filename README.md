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
  * Delete `<key>` and its value
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

## Copyright & License

    Copyright © 2016 Alexander Tamm

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
