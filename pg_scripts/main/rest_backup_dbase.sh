#!/bin/bash
#
# RGS Модуль восстановления базы из бэкапа pg_dump в базу
#
# Пример запуска стартера:            ./rest_backup_dbase_name.sh
# Пример запуска исполняемого модуля: ./rest_backup_dbase.sh srv01 5432 dbsaler1 postgres 3 /pgbackup/dbsaler1_now

USAGE_STRING="Использовать: $0 hosthame port dbname username jobs backup_dir
Пример: $0 srv01 5432 dbsaler1 postgres 3 /pgbackup"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit
fi

srvname=$1
port=$2
dbname=$3
username=$4
jobs=$5
backup_dir=$6

if /opt/pgpro/std-15/bin/dropdb --host $srvname --port $port --username $username --if-exists --no-password --echo $dbname; then

    if /opt/pgpro/std-15/bin/createdb --host $srvname --port $port --username $username --echo --owner $username --no-password --encoding UTF8 --tablespace pg_default $dbname; then

		if /opt/pgpro/std-15/bin/pg_restore --host $srvname --port $port --username $username --no-password --dbname $dbname --jobs $jobs --verbose $backup_dir; then

			/opt/pgpro/std-15/bin/vacuumdb --host $srvname --port $port --username $username --no-password --dbname $dbname --jobs $jobs --analyze --freeze

		else
	    	echo "Базу \"$dbname\" восстановить из бэкапа \"$backup_dir\" не получилось..."
		fi
    else
		  echo "Базу \"$dbname\" создать не получилось..."
    fi
else
    echo "Базу \"$dbname\" удалить не получилось..."
fi
