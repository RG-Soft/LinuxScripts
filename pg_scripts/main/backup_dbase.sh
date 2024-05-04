#!/bin/bash

#
# RGS бэкапирование базы кластера
#
#Пример запуска стартера:            ./backup_dbname.sh
#Прмиер запуска исполняемого модуля: ./backup_dbase.sh srv01 5432 db_saler postgres 3 /pgbackup 20240312_100954"

USAGE_STRING="Usage: $0 hosthame port dbname username jobs backupdir
example: ./backup_dbase.sh srv01 5432 db_saler postgres 3 /pgbackup 20240312_100954"

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
backupdir_root=$6
backup_suffix=$7

if [ ! -d "$backupdir_root" ]; then
    echo "Отсутствует корневой каталог бэкапов! Создайте и настройте корневой каталог $backupdir_root..."
    exit 100
fi

backupdir=${backupdir_root}/${dbname}/${dbname}${backup_suffix}
backupdir_inprogress=${backupdir}.backuping

if [ -d "$backupdir_inprogress" ]; then
    echo "Бэкап уже выполняется! Если был прерван - удалите каталог $backupdir_inprogress вручную"
    exit 101
fi

if [ ! -d "$backupdir" ]; then
    mkdir -p $backupdir_inprogress
else
    rm -f $backupdir/*
    mv $backupdir $backupdir_inprogress
fi

echo "--==Start  $dbname backup==--"
pg_dump --host $srvname --port $port --username $username --no-password --format directory --jobs $jobs --blobs --encoding UTF8 --verbose --file $backupdir_inprogress $dbname
echo "--==Finish $dbname backup==--"

mv $backupdir_inprogress $backupdir
