#!/bin/bash

#
# RGS Стартер ежедневного регламента vacuumdb базы кластера
#
#Пример запуска стартера:            ./vacuumdb_dbname.sh
#Прмиер запуска исполняемого модуля: ./vacuumdb_dbase.sh srv01 5432 DBName postgres 3"

dbname=PAWCMFR
srvname=localhost
port=5432
username=postgres
jobs=2
freeze=freeze

$(dirname ${BASH_SOURCE[0]})`/vacuumdb_dbase.sh $srvname $port $dbname $username $jobs $freeze