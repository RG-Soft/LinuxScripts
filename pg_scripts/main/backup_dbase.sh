#!/bin/bash
#
# RGS бэкапирование базы кластера
#
# Пример запуска стартера:            ./backup_dbname.sh
# Прмиер запуска исполняемого модуля: ./backup_dbase.sh srv01 5432 db_saler postgres 3 /pgbackup 20240312_100954"

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

# Добавим опциональный параметр verbose для контроля
#verbose="--verbose"
verbose=""

echo "--==Start  $dbname backup==--"
echo "Выполняется проверка готовности к запуску..."
if [ ! -d "$backupdir_root" ]; then
    echo "Отсутствует корневой каталог бэкапов! Создайте и настройте корневой каталог ${backupdir_root}..."
    exit 100
fi

backupdir=${backupdir_root}/${dbname}/${dbname}${backup_suffix}
backupdir_inprogress=${backupdir}.backuping

if [ -d "$backupdir_inprogress" ]; then
    echo "Бэкап уже выполняется! Если был прерван - удалите каталог ${backupdir_inprogress} вручную"
    exit 100
fi

if [ ! -d "$backupdir" ]; then
    echo -n "Каталог бэкапа отсутствует ... "
    if ! mkdir -p $backupdir_inprogress ; then
        echo "ОШИБКА!!! при создания временного каталога ${backupdir_inprogress}"
        exit 100
    else
        echo "Создан для работы ${backupdir_inprogress}"
    fi
else
    if ! rm -f "$backupdir"/* ; then
        echo "ОШИБКА!!! не удалось удалить файлы старого бэкапа"
        exit 100
    fi
    if ! mv "$backupdir" "$backupdir_inprogress" ; then
        echo "ОШИБКА!!! не удалось переименовать каталог бэкапа во временный ${backupdir_inprogress}"
        exit 100
    fi
fi
echo "Проверка выполнена. ОК!"

exit_code=0

if pg_dump --host $srvname --port $port --username $username --no-password --format directory --jobs $jobs --blobs --encoding UTF8 $verbose --file $backupdir_inprogress $dbname ; then
    echo "Бэкап выполнен. ОК!"
    if mv "$backupdir_inprogress" "$backupdir" ; then
        echo "Временный каталог переименован в ${backupdir}"
    else
        echo "ОШИБКА!!! Временный каталог не переименован"
        exit_code=100
    fi
else
    echo "ОШИБКА!!! Бэкап не выполнен."
    exit_code=100
fi
echo "--==Finish $dbname backup==--"
exit $exit_code
