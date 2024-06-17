#!/bin/bash
#
# RGS Стартер копирования бэкапов базы в отдельный каталог
#
# Пример запуска стартера:            ./backup_copy_dbase_name.sh

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=TOEZGP
backupdir=/pgbackup/$dbname/${dbname}_now
copydir=/mnt/ru0222nas02_YANDEX/ru0222app53/SQLBackup/${dbname}/${dbname}_now #$(date +'%Y%m%d')
#\\ru0222nas02.dir.slb.com\YANDEX_RU_ES_LEGACY\EAR-AA-1315\SQLBACKUP\ru0994app40\SQLBackup\TOEZGP\TOEZGP_now
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/backup_copy_dir.sh $dbname $backupdir $copydir
