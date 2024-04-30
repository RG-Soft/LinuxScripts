#!/bin/bash
#
# RGS Стартер установки repack во все базы кластера
#
#Пример запуска стартера:            ./repack_install_cluster_5432.sh
#Прмиер запуска исполняемого модуля: ./repack_install_cluster.sh srv01 5432 postgres"

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
srvname=localhost
port=5434
username=postgres
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/repack_install_cluster.sh $srvname $port $username
