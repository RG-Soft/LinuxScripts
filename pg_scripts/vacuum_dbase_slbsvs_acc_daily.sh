#!/bin/bash
#
# RGS Стартер модуля регламента vacuumdb ежедневного vacuumdb базы кластера
#
# Пример запуска стартера:            ./vacuum_dbase_name_daily.sh 
# Прмиер запуска исполняемого модуля: ./vacuum_dbase.sh srv01 5432 DBName postgres 3" 

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=slbSVS_acc
srvname=localhost
port=5434
username=postgres
jobs=4
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/vacuum_dbase.sh $srvname $port $dbname $username $jobs
