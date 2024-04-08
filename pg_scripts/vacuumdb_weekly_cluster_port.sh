#!/bin/bash
#
# RGS Стартер модуля регламента vacuumdb еженедельного для всех баз кластера.
#
#Пример запуска модуля:              ./vacuumdb_weekly_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./vacuumdb_cluster.sh srv01 5432 postgres FREEZE"

srvname=localhost
port=5432
username=postgres
jobs=3
freeze=FREEZE

./vacuum_cluster.sh $srvname $port $username $jobs $freeze
