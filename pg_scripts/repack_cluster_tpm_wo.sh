#!/bin/bash

#
# RGS Стартер регламента repack всех баз кластера. НО ТОЛЬКО "убитых" таблиц и индексов
#
#Пример запуска стартера:            ./repack_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./repack_cluster.sh srv01 5432 postgres 3 "base1 base3"

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
srvname=localhost
port=5433
username=postgres
jobs=3
skip_userdblist=""
# ///////////////////////////////////////////////////////////////

# ///////////////////////////////////////////////////////////////
# Параметры системные, править не требуется
skip_systemdblist="\N template0 template1 postgres"
# ///////////////////////////////////////////////////////////////

skip_dblist="${skip_systemdblist} ${skip_userdblist}"
$(dirname ${BASH_SOURCE[0]})/main/repack_cluster.sh $srvname $port $username $jobs "$skip_dblist"
