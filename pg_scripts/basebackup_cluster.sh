#!/bin/bash
#
# RGS Модуль регламента basebackup для кластера.
#
#Пример запуска модуля:              ./basebackup_5432.sh
#Прмиер запуска исполняемого модуля: ./basebackup_cluster.sh srv01 5432 postgres"

USAGE_STRING="Использовать: $0 hosthame port username backupdir
Пример: ./repack_cluster_port.sh db_saler srv01 5432 postgres /pgbackup"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit 1
fi

###############
clustername=$1
srvname=$2
port=$3
username=$4
backupdir_root=$5

backupdir=$backupdir_root/$clustername/basebackup/${clustername}_$(date +'%Y%m%d')
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
pg_basebackup --host $srvname --port $port --username $username --no-password --wal-method=none --format=tar --gzip --checkpoint=fast --progress --verbose --pgdata $backupdir_inprogress
echo "--==Finish cluster $port pg_basebackup==--"

mv $backupdir_inprogress $backupdir
