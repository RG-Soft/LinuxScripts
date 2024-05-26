#!/bin/bash
#
# RGS Стартер копирования бэкапов базы в отдельный каталог
#
# Пример запуска стартера:            ./backup_copy_dir_dbname.sh

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=Zakupki
backupdir=/pgbackup/$dbname/${dbname}_now
copydir=/mnt/ru0222nas02_YANDEX/ru0994app40/SQLBackup/${dbname}/${dbname}_$(date +'%Y%m%d')
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/backup_copy_dir.sh $dbname $backupdir $copydir
