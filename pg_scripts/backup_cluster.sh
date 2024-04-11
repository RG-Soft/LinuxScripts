#!/bin/bash
#
# RGS Стартер бэкапирование всех баз кластера
#
#Пример запуска стартера:            ./backup_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./backup_cluster.sh srv01 5432 postgres 3 /pgbackup 20240312_100954"

USAGE_STRING="Использовать: $0 hosthame port username jobs backup_dir time_lable
Пример: ./repack_cluster_port.sh srv01 5432 postgres 3 /pgbackup 2024_05_04-10_10"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit 1
fi

srvname=$1
port=$2
username=$3
jobs=$4
backupdir_root=$5
backup_suffix=$6

echo "--==Start  backup base in cluster $port ==--"

# Получаем список баз данных
dblist=`psql --dbname=postgres --host=$srvname --port=$port --username=$username --command="copy (select datname from pg_stat_database) to stdout"`

echo "Список баз к обработке:"
echo "$dblist"

for dbname in $dblist ; do

    # Игнорируем служебные базы данных
    if [[ $dbname == "\N" ]] || [[ $dbname == "template0" ]] ||  [[ $dbname == "template1" ]] || [[ $dbname == "postgres" ]] ; then
	echo "База \"$dbname\" пропускается..."
        continue
    fi

    echo "Обрабатывается база \"$dbname\""

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

done

echo "--==Finish backup base in cluster $port==--"
