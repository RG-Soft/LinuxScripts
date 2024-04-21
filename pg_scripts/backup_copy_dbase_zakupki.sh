#!/bin/bash
#
# RGS Стартер копирования бэкапов базы в отдельный каталог
#
#Пример запуска стартера:            ./backup_copy_dbase_name.sh

dbasename=Zakupki
backupdir=/pgbackup/$dbasename/${dbasename}_now
copydir=/mnt/ru0994app40_sqlbackup/${dbasename}_$(date +'%Y%m%d')

if [ ! -d "$copydir" ]; then
    mkdir -p $copydir
else
   rm -f $copydir/*
fi

cp $backupdir/* $copydir/
