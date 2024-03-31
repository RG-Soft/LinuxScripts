#!/bin/bash

clustername=1CHelper
hostname=localhost
port=5435
username=postgres
backupdir=/pgbackup/$clustername/basebackup/${clustername}_$(date +'%Y%m%d')
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

echo "--==Start cluster $port pg_basebackup==--"
pg_basebackup --host $hostname --port $port --username $username --no-password --wal-method=none --format=tar --gzip --checkpoint=fast --progress --verbose --pgdata $backupdir_inprogress
echo "--==Finish cluster $port pg_basebackup==--"

mv $backupdir_inprogress $backupdir
