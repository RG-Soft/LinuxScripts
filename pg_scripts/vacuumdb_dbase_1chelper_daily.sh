#!/bin/bash

#
# RGS Стартер ежедневного регламента vacuumdb базы кластера
#
#Пример запуска стартера:            ./vacuumdb_dbase_name_daily.sh 
#Прмиер запуска исполняемого модуля: ./vacuumdb_dbase.sh srv01 5432 DBName postgres 3" 

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=1CHelper
srvname=localhost
port=5435
username=postgres
jobs=3
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/vacuumdb_dbase.sh $srvname $port $dbname $username $jobs
