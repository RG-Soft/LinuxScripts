#!/bin/bash

#
# RGS Стартер бэкапирование базы кластера
#
#Пример запуска стартера:            ./backup_dbname.sh
#Прмиер запуска исполняемого модуля: ./backup_dbase.sh srv01 5432 db_saler postgres 3 /pgbackup 20240312_100954"

dbname=slbSmithFA
srvname=localhost
port=5432
username=postgres
jobs=1
backupdir_root=/pgbackup
backup_suffix=_now # История бэкапов не ведется, бэкап используется для перезаливки баз разработчиков
#backup_suffix=$(date +'%Y%m%d_%H%M%S') # История бэкапов ведется, бэкап сохраняется в каталог с меткой времени

/var/lib/postgresql/backup_dbase.sh $srvname $port $dbname $username $jobs $backupdir_root $backup_suffix
