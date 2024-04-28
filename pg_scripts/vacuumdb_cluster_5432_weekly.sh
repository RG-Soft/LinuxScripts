#!/bin/bash
#
# RGS Стартер модуля регламента vacuumdb еженедельного для всех баз кластера.
#
#Пример запуска модуля:              ./vacuumdb_cluster_5432_weekly.sh
#Прмиер запуска исполняемого модуля: ./vacuumdb_cluster.sh srv01 5432 postgres 3 "base1 base3" FREEZE

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
srvname=localhost
port=5432
username=postgres
jobs=1
skip_userdblist=""
freeze=FREEZE
# ///////////////////////////////////////////////////////////////

# ///////////////////////////////////////////////////////////////
# Параметры системные, править не требуется
skip_systemdblist="\N template0 template1 postgres"
# ///////////////////////////////////////////////////////////////

skip_dblist="${skip_systemdblist} ${skip_userdblist}"
$(dirname ${BASH_SOURCE[0]})/vacuumdb_cluster.sh $srvname $port $username $jobs "$skip_dblist" $freeze
