#!/bin/bash
#
# RGS Модуль регламента vacuumdb для всех баз кластера
#
#Пример запуска стартера ежедневный  : ./vacuumdb_daily_cluster_5432.sh
#Пример запуска стартера еженедельный: ./vacuumdb_weekly_cluster_5432.sh
#Прмиер запуска исполняемого модуля  : ./vacuumdb_cluster.sh srv01 5432 postgres 3 [FREEZE]"

USAGE_STRING="Использовать: $0 hosthame port dbname username jobs [FREEZE]
Пример: ./vacuum_daily_cluster.sh srv01 5432 postgres 
Пример: ./vacuum_daily_cluster.sh srv01 5432 postgres FREEZE"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit 1
fi

srvname=$1
port=$2
username=$3
jobs=$4
freeze=""

if [ ! "$6" == "" ]; then
    freeze="$6,"
    #echo "Параметр freeze: $freeze"
fi

# Получаем список баз данных
dblist=`/opt/pgpro/std-15/bin/psql --dbname=postgres --host=$srvname --port=$port --username=$username --command="copy (select datname from pg_stat_database) to stdout"`
for dbname in $dblist ; do

    # Игнорируем служебные базы данных
    if [ "$dbname" = "\N" ] || [ "$dbname" = "template0" ] ||  [ "$dbname" == "template1" ] || [ "$dbname" == "postgres" ] ; then
	echo 'База \"$dbname\" пропускается...'
        continue
    fi

    # Проводим сборку мусора и анализ базы данных, фриизим
    echo 'Обрабатывается база: '$dbname
    /opt/pgpro/std-15/bin/psql --dbname=$dbname --host=$srvname --port=$port --username=$username --echo-queries --echo-all --command="VACUUM(ANALYZE,${freeze}PARALLEL $jobs);"

done
