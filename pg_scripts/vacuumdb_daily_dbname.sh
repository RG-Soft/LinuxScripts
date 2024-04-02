#!/bin/bash

#
# RGS Стартер ежедневного регламента vacuumdb базы кластера
#
#Пример запуска стартера:            ./vacuumdb_dbname.sh 
#Прмиер запуска исполняемого модуля: ./vacuumdb_dbase.sh srv01 5432 DBName postgres 3" 

dbname=DBase
srvname=localhost
port=5432
username=postgres
jobs=3

./vacuumdb_dbase.sh $srvname $port $dbname $username $jobs