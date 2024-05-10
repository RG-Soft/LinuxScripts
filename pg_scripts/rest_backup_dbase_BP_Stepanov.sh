#!/bin/bash

#. Введите имя базы в которую надо залить бэкап
dbname=Spectr_BP_Stepanov
#. Введите адрес каталога бэкапа
backup_dir=/mnt/pgbackup/Spectr_BP_20240322	# Бэкап на рабочем сервере
#backup_dir=/pgbackup/current_backup/now		# Бэкап на текущем сервере


hostname=localhost
port=5432
username=postgres
jobs=3

if /opt/pgpro/std-15/bin/dropdb --host $hostname --port $port --username $username --if-exists --no-password --echo $dbname; then

    if /opt/pgpro/std-15/bin/createdb --host $hostname --port $port --username $username --echo --owner $username --no-password --encoding UTF8 --tablespace pg_default $dbname; then

	if /opt/pgpro/std-15/bin/pg_restore --host $hostname --port $port --username $username --no-password --dbname $dbname --jobs $jobs --verbose $backup_dir; then

	    /opt/pgpro/std-15/bin/vacuumdb --host $hostname --port $port --username $username --no-password --dbname $dbname --jobs $jobs --analyze --freeze

	else
	    echo "Базу \"$dbname\" восстановить из бэкапа \"$backup_dir\" не получилось..."
	fi
    else
	echo "Базу \"$dbname\" создать не получилось..."
    fi
else
    echo "Базу \"$dbname\" удалить не получилось..."
fi
