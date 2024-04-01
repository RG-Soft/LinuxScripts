#!/bin/bash

#
# RGS регламент vacuumdb еженедельный базы кластера
#

USAGE_STRING="Usage: $0 hosthame port dbname username jobs
example: ./backup_dbname.sh srv01 5432 db_saler postgres 3"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit 1
fi

#test param
#echo "$@"

srvname=$1
port=$2
dbname=$3
username=$4
jobs=$5

echo "--==Start  $dbname vacuum weekly==--"
vacuumdb --host $srvname --port $port --username $username --no-password --jobs $jobs $dbname --analyze --freeze
echo "--==Finish $dbname vacuum weekly==--"
