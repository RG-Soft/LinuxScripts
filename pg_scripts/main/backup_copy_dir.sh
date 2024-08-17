#!/bin/bash
#
# RGS Модуль копирования каталогов в отдельный каталог (облако)
#
# Пример запуска модуля:            ./backup_directory_copy.sh Zakupki source_root_dir dest_root_dir

SAGE_STRING="Использовать: $0 dbname||clusterport source_root_dir dest_root_dir
Пример: ./backup_copy_dir.sh Zakupki /pgbackup/Zakkupki/Zakupki_now /mnt/ru0222nas02/SQLBackup/Zakupki"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit
fi

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=$1
backupdir=$2
copydir=$3
# ///////////////////////////////////////////////////////////////

echo "--~== Запускаем копирование бэкапа базы ${dbname} ==~--"

if [ ! -d "$backupdir" ]; then
    echo -n "Каталог бэкапирования ${backupdir} не найден, копирование прерываем ... "
    exit
else
    echo "Каталог бэкапирования ${backupdir} существует."
fi

if [ ! -d "$copydir" ]; then
    echo -n "Каталог целевой ${copydir} не найден ... "
    if mkdir -p "$copydir" ; then
        echo "Создан!"
        echo "Целевой каталог копирования: '${copydir}/'"
    else
        echo "Ошибка!!!"
        echo "Целевой каталог '${copydir}/' не создан"
        exit
    fi
else
    echo "Целевой каталог ${copydir} существует."
    echo -n "Запускаем зачистку перед копированием ... "
    rm -f "$copydir"/*
    echo "Выполнено!"
fi

exit_code=0

echo -n "Запускаем копирование в ${copydir} ... "
if cp "$backupdir"/* "$copydir"/ ; then
    echo "Выполнено!"
else
    echo "ОШИБКА!!! не выполнено."
    exit_code=100
fi
echo "--~== Завершено копирование бэкапа базы ${dbname} ==~--"
# не нулевой код вовзрата прерывает цепочку запуска скриптов в сервис юните
#exit $exit_code
