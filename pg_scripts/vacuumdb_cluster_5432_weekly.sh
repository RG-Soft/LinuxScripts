#!/bin/bash
#
# RGS Стартер модуля регламента vacuumdb еженедельного для всех баз кластера.
#
#Пример запуска модуля:              ./vacuumdb_cluster_5432_weekly.sh
#Прмиер запуска исполняемого модуля: ./vacuumdb_cluster.sh srv01 5432 postgres 3 FREEZE"

srvname=localhost
port=5432
username=postgres
jobs=3
freeze=FREEZE

$(dirname ${BASH_SOURCE[0]})/vacuumdb_cluster.sh $srvname $port $username $jobs $freeze
