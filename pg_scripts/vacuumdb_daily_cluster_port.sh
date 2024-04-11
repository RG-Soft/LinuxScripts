#!/bin/bash
#
# RGS Стартер модуля регламента vacuumdb ежеднечного для всех баз кластера.
#
#Пример запуска модуля:              ./vacuumdb_daily_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./vacuumdb_cluster.sh srv01 5432 postgres 3"

srvname=localhost
port=5432
username=postgres
jobs=3

`pwd`/vacuumdb_cluster.sh $srvname $port $username $jobs
