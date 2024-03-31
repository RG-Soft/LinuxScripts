#!/bin/bash

#
# RGS Стартер бэкапирование базы кластера
#
#Пример запуска стартера:            ./backup_dbname.sh
#Прмиер запуска исполняемого модуля: ./backup_dbase.sh srv01 5432 DBName postgres 3 /pgbackup"

dbname=TOEZGP
hostname=localhost
port=5432
username=postgres
jobs=3
backupdir_root=/pgbackup

./backup_dbase.sh $hosthame $port $dbname $username $jobs $backupdir_root
