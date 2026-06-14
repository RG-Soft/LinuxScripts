#!/bin/bash
#
# RGS Стартер копирования бэкапов базы в отдельный каталог
#
# Пример запуска стартера:            ./backup_copy_dir_dbname.sh

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=Zakupki
backupdir=/pgbackup/$dbname/${dbname}_now

# История бэкапов ведется, бэкап сохраняется в каталог с меткой времени
#copydir=/mnt/ru0149bck01_SQLBackups/ru0994app40/SQLBackup/${dbname}/${dbname}_$(date +'%Y%m%d')

# История бэкапов не ведется, бэкап используется для перезаливки баз разработчиков
 copydir=/mnt/ru0149bck01_SQLBackups/ru0222app48/SQLBackup/${dbname}/${dbname}_now
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/backup_copy_dir.sh $dbname $backupdir $copydir
