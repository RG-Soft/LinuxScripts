#!/bin/bash
#
# RGS Стартер копирования бэкапов базы в отдельный каталог
#
# Пример запуска стартера:            ./backup_copy_dbase_name.sh

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=tmk_upp
backupdir=/pgbackup/$dbname/${dbname}_now
#copydir=/mnt/ruapp40_sqlbackup/${dbname}_$(date +'%Y%m%d')
copydir=/mnt/ru0149bck01_SQLBackups/ru0149app149/SQLBackup/${dbname}/${dbname}_now
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/backup_copy_dir.sh $dbname $backupdir $copydir
