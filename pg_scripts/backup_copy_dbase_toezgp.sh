#!/bin/bash
#
# RGS Стартер копирования бэкапов базы в отдельный каталог
#
#Пример запуска стартера:            ./backup_copy_dbase_name.sh

dbasename=TOEZGP
backupdir=/pgbackup/$dbasename/${dbasename}_now
copydir=/mnt/ru0222nas02_YANDEX/ru0994app40/SQLBackup/${dbasename}/${dbasename}_now #$(date +'%Y%m%d')
#\\ru0222nas02.dir.slb.com\YANDEX_RU_ES_LEGACY\EAR-AA-1315\SQLBACKUP\ru0994app40\SQLBackup\TOEZGP\TOEZGP_now

if [ ! -d "$copydir" ]; then
    mkdir -p $copydir
else
   rm -f $copydir/*
fi

cp $backupdir/* $copydir/
