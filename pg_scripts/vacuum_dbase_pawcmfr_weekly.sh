#!/bin/bash
#
# RGS Стартер модуля регламента vacuumdb базы кластера 
#
# Пример запуска стартера:            ./vacuum_dbase_name_weekly.sh 
# Прмиер запуска исполняемого модуля: ./vacuum_dbase.sh srv01 5432 DBName postgres 3 freeze" 

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=PAWCMFR
srvname=localhost
port=5432
username=postgres
jobs=2
freeze=FREEZE
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/vacuum_dbase.sh $srvname $port $dbname $username $jobs $freeze
