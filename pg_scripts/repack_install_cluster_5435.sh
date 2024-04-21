#!/bin/bash
#
# RGS Стартер установки repack во все базы кластера
#
#Пример запуска стартера:            ./repack_install_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./repack_install_cluster.sh srv01 5432 postgres"

srvname=localhost
port=5435
username=postgres

$(dirname ${BASH_SOURCE[0]})/repack_install_cluster.sh $srvname $port $username

