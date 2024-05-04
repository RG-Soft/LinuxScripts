#!/bin/bash
#
# RGS Модуль установки repack во все базы кластера
#
#Пример запуска стартера:            ./repack_install_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./repack_install_cluster.sh srv01 5432 postgres"

USAGE_STRING="Использовать: $0 hosthame port username
Пример: ./repack_install_cluster.sh srv01 5432 postgres"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit 1
fi

srvname=$1
port=$2
username=$3

# Получаем список баз данных
dblist=`/opt/pgpro/std-15/bin/psql --dbname=postgres --host=$srvname --port=$port --username=$username --command="copy (select datname from pg_stat_database) to stdout"`

for dbname in $dblist ; do

    # Игнорируем служебные базы данных
    #if [ $dbname == '\N' ] || [$dbname == 'template0' ] ||  [ $dbname == 'template1' ] || [ $dbname == 'postgres' ] ; then
    if [ "$dbname" = "\N" ] || [ "$dbname" = "template0" ] ||  [ "$dbname" == "template1" ] || [ "$dbname" == "postgres" ] ; then
	echo "База " $dbname " пропускается..."
        continue
    fi

    # Удаление и Установка pg_repack
    echo 'Обрабатывается база: '$dbname

    /opt/pgpro/std-15/bin/psql --dbname=$dbname --host=$srvname --port=$port --username=$username --echo-queries --echo-all --command="DROP EXTENSION IF EXISTS pg_repack;"
    /opt/pgpro/std-15/bin/psql --dbname=$dbname --host=$srvname --port=$port --username=$username --echo-queries --echo-all --command="CREATE EXTENSION pg_repack;"

done
