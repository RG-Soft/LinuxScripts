#!/bin/bash

dbname=Spectr_Zup
hostname=localhost
port=5432
username=postgres
jobs=3

vacuumdb --host $hostname --port $port --username $username --no-password --jobs $jobs $dbname --analyze --freeze
