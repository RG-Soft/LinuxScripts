#!/bin/bash
#
# RGS Модуль регламента vacuumdb для всех баз кластера
#
# Пример запуска стартера ежедневный  : ./vacuumdb_cluster_5432_daily.sh
# Пример запуска стартера еженедельный: ./vacuumdb_cluster_5432_weekly.sh
# Прмиер запуска исполняемого модуля  : ./vacuumdb_cluster.sh srv01 5432 postgres 3 "base1 base3" [FREEZE]

USAGE_STRING="Использовать: $0 hosthame port dbname username jobs [FREEZE]
Пример ежедневный  : ./vacuumdb_cluster.sh srv01 5432 postgres 3 \"base1 base3\"
Пример еженедельный: ./vacuumdb_cluster.sh srv01 5432 postgres 3 \"base1 base3\" FREEZE"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit
fi

srvname=$1
port=$2
username=$3
jobs=$4
skip_dblist=$5
freeze=""
type="daily"

if [ ! "$6" == "" ] && [ "$6" == "FREEZE" ]; then
    freeze="--freeze"
    type="weekly"
    #echo "Параметр freeze: $freeze"
fi

# Получаем список баз данных
dblist=`/opt/pgpro/std-15/bin/psql --dbname=postgres --host=$srvname --port=$port --username=$username --command="copy (select datname from pg_stat_database) to stdout"`
for dbname in $dblist ; do

    # Игнорируем служебные или исключенные базы данных
    if echo "$skip_dblist" | grep -qw "$dbname"; then
		echo "Системная или исключенная из обработки база \"$dbname\" пропускается..."
		continue
    fi

    # Проводим сборку мусора и анализ базы данных, фриизим
    echo "--==Start  $dbname vacuum $type==--"
    vacuumdb --host $srvname --port $port --username $username --no-password --jobs $jobs $dbname --analyze $freeze
    echo "--==Finish $dbname vacuum $type==--"

done
