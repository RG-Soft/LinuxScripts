#!/bin/bash

#
# RGS Стартер бэкапирование всех баз кластера
#
#Пример запуска стартера:            ./backup_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./backup_cluster.sh srv01 5432 postgres 3 /pgbackup 20240312_100954"

srvname=localhost
port=5432
username=postgres
jobs=3
backupdir_root=/pgbackup
backup_suffix=_now # История бэкапов не ведется, бэкап используется для перезаливки баз разработчиков
#backup_suffix=$(date +'%Y%m%d_%H%M%S') # История бэкапов ведется, бэкап сохраняется в каталог с меткой времени

./backup_cluster.sh $srvname $port $username $jobs $backupdir_root $backup_suffix
