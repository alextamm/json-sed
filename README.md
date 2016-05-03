# json-sed

For want of a better name...

# Purpose

The script contained reads JSON from STDIN and manipulates it according to the parameters and prints
to STDOUT. Primary use case for me has been to delete extra stuff from JSON objects when doing CRUD operations with curl.

# Parameters

* [--pretty|-p]
** Make the output human readable by adding whitespace
* [--reduce|-r <key>]
** Remove everything else and move the value of <key> to the "root"

** e.g with -r foo, this: {"foo":{"bar":1,"fubar":"string"}}
** Will become this: {"bar":1,"fubar":"string"}

