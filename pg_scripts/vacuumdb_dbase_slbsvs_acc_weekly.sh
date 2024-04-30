#!/bin/bash

#
# RGS Стартер еженедельного регламента vacuumdb базы кластера 
#
#Пример запуска стартера:            ./vacuumdb_dbase_name_weekly.sh 
#Прмиер запуска исполняемого модуля: ./vacuumdb_dbase.sh srv01 5432 DBName postgres 3 freeze" 

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=slbSVS_acc
srvname=localhost
port=5434
username=postgres
jobs=2
freeze=FREEZE
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/vacuumdb_dbase.sh $srvname $port $dbname $username $jobs $freeze