#!/bin/bash

dbname=Spectr_Zup
srvname=localhost
port=5432
username=postgres
jobs=3
backupdir=/mnt/pgbackup/${dbname}_$(date +'%Y%m%d')
backupdir_inprogress=$backupdir.backuping

if [ -d "$backupdir_inprogress" ]; then
    echo "Бэкап уже выполняется! Если был прерван - удалите каталог $backupdir_inprogress вручную"
    exit 100
fi

if [ ! -d "$backupdir" ]; then
    mkdir -p $backupdir_inprogress
else
    rm -f $backupdir/*
    mv $backupdir $backupdir_inprogress
fi

pg_dump --host $srvname --port $port --username $username --no-password --format directory --jobs $jobs --blobs --encoding UTF8 --verbose --file $backupdir_inprogress $dbname

mv $backupdir_inprogress $backupdir
