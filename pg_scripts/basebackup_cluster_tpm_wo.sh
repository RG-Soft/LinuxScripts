#!/bin/bash
#
# RGS Стартер модуль регламента basebackup для кластера.
#
#Пример запуска модуля:              ./basebackup_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./basebackup_cluster.sh srv01 5432 postgres db_saler /pgbackup"

clustername=TPM_WO # можно использовать номер порта, если кластен не именной, по имени базы.
srvname=localhost
port=5433
username=postgres
backupdir_root=/pgbackup

$(dirname ${BASH_SOURCE[0]})/basebackup_cluster.sh $srvname $port $username $clustername $backupdir_root
