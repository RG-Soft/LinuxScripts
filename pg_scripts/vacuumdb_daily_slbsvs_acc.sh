#!/bin/bash

#
# RGS Стартер ежедневного регламента vacuumdb базы кластера
#
#Пример запуска стартера:            ./vacuumdb_dbname.sh
#Прмиер запуска исполняемого модуля: ./vacuumdb_dbase.sh srv01 5432 DBName postgres 3"

dbname=slbSVS_acc
srvname=localhost
port=5434
username=postgres
jobs=3

/var/lib/postgresql/vacuumdb_dbase.sh $srvname $port $dbname $username $jobs