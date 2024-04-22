#!/bin/bash
#
# RGS Стартер копирования бэкапов базы в отдельный каталог
#
#Пример запуска стартера:            ./backup_copy_dbase_name.sh

dbasename=db_saler
backupdir=/pgbackup/$dbasename/${dbasename}_now
copydir=/mnt/ru0994app40_sqlbackup/${dbasename}_$(date +'%Y%m%d')

echo "Запускаем копирование бэкапа базы ${dbasename} ..."
if [ ! -d "$copydir" ]; then
    echo -n "Каталог целевой ${copydir} не найден, создаем ... "
    mkdir -p $copydir
    echo "Выполнено!"
else
    echo -n "Каталог целевой  ${copydir} существует, запускаем зачистку перед копированием ... "
    rm -f $copydir/*
    echo "Выполнено!"
fi

echo -n "Запускаем копирование в ${copydir} ... "
cp $backupdir/* $copydir/
echo "Выполнено!"
