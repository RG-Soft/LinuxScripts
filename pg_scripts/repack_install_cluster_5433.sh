#!/bin/bash
#
# RGS Стартер установки repack во все базы кластера
#
#Пример запуска стартера:            ./repack_install_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./repack_install_cluster.sh srv01 5432 postgres"

srvname=localhost
port=5433
username=postgres

./repack_install_cluster.sh $srvname $port $username
