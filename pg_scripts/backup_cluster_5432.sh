#!/bin/bash
#
# RGS Стартер бэкапирование всех баз кластера
#
# Пример запуска стартера:            ./backup_cluster_5432.sh
# Прмиер запуска исполняемого модуля: ./backup_cluster.sh srv01 5432 postgres 3 /pgbackup 20240312_100954 "base1 base2"

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
srvname=localhost
port=5432
username=postgres
jobs=1
backupdir_root=/pgbackup
backup_suffix=_now # История бэкапов не ведется, бэкап используется для перезаливки баз разработчиков
#backup_suffix=$(date +'%Y%m%d_%H%M%S') # История бэкапов ведется, бэкап сохраняется в каталог с меткой времени
skip_userdblist="base1 base3"
# ///////////////////////////////////////////////////////////////

# ///////////////////////////////////////////////////////////////
# Параметры системные, править не требуется
skip_systemdblist="\N template0 template1 postgres"
# ///////////////////////////////////////////////////////////////

skip_dblist="${skip_systemdblist} ${skip_userdblist}"
$(dirname ${BASH_SOURCE[0]})/backup_cluster.sh $srvname $port $username $jobs $backupdir_root $backup_suffix "$skip_dblist"
