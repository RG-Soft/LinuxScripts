#!/bin/bash
#
# RGS Стартер модуль регламента basebackup для кластера.
#
# Пример запуска модуля:              ./basebackup_cluster_5432.sh
# Пример запуска исполняемого модуля: ./basebackup_cluster.sh srv01 5432 postgres db_saler /pgbackup NO

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируются под настройки серверов
clustername=5433 # можно использовать номер порта, если кластен не именной, по имени базы.
srvname=localhost
port=5433
username=postgres
backupdir_root=/pgbackup
backupdir_rewrite=NO #YES включает удаление старого бэкапа. Удаление хвостов протерянных WAL файлов - вручную
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/basebackup_cluster.sh $srvname $port $username $clustername $backupdir_root $backupdir_rewrite
