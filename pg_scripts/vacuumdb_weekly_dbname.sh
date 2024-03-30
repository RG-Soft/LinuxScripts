#!/bin/bash

dbname=1CHelper
hostname=localhost
port=5435
username=postgres
jobs=3

echo "--==Start  $dbname vacuum weekly==--"
vacuumdb --host $hostname --port $port --username $username --no-password --jobs $jobs $dbname --analyze --freeze
echo "--==Finish $dbname vacuum weekly==--"
