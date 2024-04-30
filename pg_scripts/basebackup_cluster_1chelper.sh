#!/bin/bash
#
# RGS Стартер модуль регламента basebackup для кластера.
#
#Пример запуска модуля:              ./basebackup_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./basebackup_cluster.sh srv01 5432 postgres db_saler /pgbackup

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
clustername=1CHelper # можно использовать номер порта, если кластен не именной, по имени базы.
srvname=localhost
port=5435
username=postgres
backupdir_root=/pgbackup
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/basebackup_cluster.sh $srvname $port $username $clustername $backupdir_root
