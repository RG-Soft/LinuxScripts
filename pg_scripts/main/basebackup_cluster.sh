#!/bin/bash
#
# RGS Модуль регламента basebackup для кластера.
#
#Пример запуска модуля:              ./basebackup_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./basebackup_cluster.sh srv01 5432 postgres db_saler /pgbackup NO

USAGE_STRING="Использовать: $0 hosthame port username clustername backupdir
Пример: ./basebackup_cluster.sh srv01 5432 postgres db_saler /pgbackup [NO|YES]
[NO|YES]: YES перезаписывать каталог бэкапа. WAL файлы потребуется удалить вручную при необходимости"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit 1
fi

###############
srvname=$1
port=$2
username=$3
clustername=$4
backupdir_root=$5
backupdir_rewrite=$6

backupdir=$backupdir_root/$clustername/basebackup/${clustername}_$(date +'%Y%m%d')
backupdir_inprogress=$backupdir.backuping

echo -n "Проверка на выполнение ... "
if [ -d "$backupdir_inprogress" ]; then
    echo "Бэкап уже выполняется!"
    echo "Если это остатки прерванного - удалите каталог $backupdir_inprogress вручную"
    exit 100
else
    echo "Не выполняется!"
fi

echo -n "Проверка, что сегодня выполнялся ... "
if [ "$backupdir_rewrite" == "YES" ]; then
    if [ ! -d "$backupdir" ]; then
        mkdir -p $backupdir_inprogress
    else
        rm -f $backupdir/*
        mv $backupdir $backupdir_inprogress
    fi
else
    echo "Бэкап уже выполнен сегодня!"
    echo "Если надо заново, запустите с параметром backupdir_rewrite == YES"
    exit 100
fi

echo "--==Start  cluster $clustername pg_basebackup==--"
pg_basebackup --host $srvname --port $port --username $username --no-password --wal-method=none --format=tar --gzip --checkpoint=fast --progress --verbose --pgdata $backupdir_inprogress
echo "--==Finish cluster $clustername pg_basebackup==--"

mv $backupdir_inprogress $backupdir
