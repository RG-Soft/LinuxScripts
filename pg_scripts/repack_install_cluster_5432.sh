#!/bin/bash

hostname=localhost
port=5432
username=postgres

export PGHOST=$hostname
export PGPORT=$port
export PGUSER=$username # Пользователь, от которого запустится обслуживание
#export PGPASSWORD=postgres # Пароль этого пользователя

# Получаем список баз данных
dblist=`/opt/pgpro/std-15/bin/psql --dbname=postgres --host=$hostname --port=$port --username=$username --command="copy (select datname from pg_stat_database) to stdout"`

echo $dblist

for dbname in $dblist ; do

    # Игнорируем служебные базы данных
    #if [ $dbname == '\N' ] || [$dbname == 'template0' ] ||  [ $dbname == 'template1' ] || [ $dbname == 'postgres' ] ; then
    if [ "$dbname" = "\N" ] || [ "$dbname" = "template0" ] ||  [ "$dbname" == "template1" ] || [ "$dbname" == "postgres" ] ; then
	echo "База " $dbname " пропускается..."
        continue
    fi

    # Удаление и Установка pg_repack
    echo 'Обрабатывается база: '$dbname

    /opt/pgpro/std-15/bin/psql --dbname=$dbname --host=$hostname --port=$port --username=$username --echo-queries --echo-all --command="DROP EXTENSION IF EXISTS pg_repack;"
    /opt/pgpro/std-15/bin/psql --dbname=$dbname --host=$hostname --port=$port --username=$username --echo-queries --echo-all --command="CREATE EXTENSION pg_repack;"

done
