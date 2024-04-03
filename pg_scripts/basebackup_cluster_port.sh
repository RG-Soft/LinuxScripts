#!/bin/bash
#
# RGS Стартер модуль регламента repack всех баз кластера. НО ТОЛЬКО "убитых" таблиц и индексов
#
#Пример запуска модуля:              ./repack_5432.sh
#Прмиер запуска исполняемого модуля: ./repack_cluster.sh db_saler srv01 5432 postgres /pgbackup"

clustername=db_saler
srvname=localhost
port=5435
username=postgres
backupdir_root=/pgbackup

./basebackup_cluster.sh $clustername $srvname $port $dbname $username $backupdir_root
