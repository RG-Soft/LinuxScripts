#!/bin/bash

#
# RGS Стартер регламента repack всех баз кластера. НО ТОЛЬКО "убитых" таблиц и индексов
#
#Пример запуска стартера:            ./repack_5432.sh
#Прмиер запуска исполняемого модуля: ./repack_cluster.sh srv01 5432 postgres 3"

srvname=localhost
port=5434
username=postgres
jobs=3

/var/lib/postgresql/repack_cluster.sh $srvname $port $username $jobs