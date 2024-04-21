#!/bin/bash

#
# RGS регламент еженедельный vacuumdb базы кластера
#

USAGE_STRING="Использовать: $0 hosthame port dbname username jobs [freeze]
Пример1 ежедневный  : ./vacuumdb_dbase.sh srv01 5432 db_saler postgres 3
Пример2 еженедельный: ./vacuumdb_dbase.sh srv01 5432 db_saler postgres 3 freeze"

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
freeze=""
type="daily"

if [ ! "$6" == "" ]; then
    freeze="--freeze"
    type="weekly"
    #echo "Параметр freeze: $freeze"
fi

echo "--==Start  $dbname vacuum $type==--"
vacuumdb --host $srvname --port $port --username $username --no-password --jobs $jobs $dbname --analyze $freeze
echo "--==Finish $dbname vacuum $type==--"
