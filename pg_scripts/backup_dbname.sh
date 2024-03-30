#!/bin/bash

dbname=1CHelper
hostname=localhost
port=5435
username=postgres
jobs=3
backupdir=/pgbackup/$dbname/"$dbname"_now
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

echo "--==Start  $dbname backup==--"
pg_dump --host $hostname --port $port --username $username --no-password --format directory --jobs $jobs --blobs --encoding UTF8 --verbose --file $backupdir_inprogress $dbname
echo "--==Finish $dbname backup==--"

mv $backupdir_inprogress $backupdir
