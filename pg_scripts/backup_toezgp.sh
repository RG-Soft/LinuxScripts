#!/bin/bash

#
# RGS Стартер бэкапирование базы кластера
#
#example: ./backup_dbname.sh srv01 5432 db_saler postgres 3 /pgbackup"

dbname=TOEZGP
hostname=localhost
port=5432
username=postgres
jobs=3
backupdir_root=/pgbackup

./backup_dbname.sh $hosthame $port $dbname $username $jobs $backupdir_root
