#!/bin/bash
#
# RGS Стартер бэкапирование базы кластера
#
# Пример запуска стартера:            ./backup_dbase_name.sh
# Пример запуска исполняемого модуля: ./backup_dbase.sh srv01 5432 db_saler postgres 3 /pgbackup 20240312_100954

# ///////////////////////////////////////////////////////////////
# Пользовательские параметры адаптируеются под настройки серверов
dbname=Spectr_Zup
srvname=localhost
port=5432
username=postgres
jobs=3
backupdir_root=/mnt/pgbackup
#backup_suffix=_now # История бэкапов не ведется, бэкап используется для перезаливки баз разработчиков
backup_suffix=$(date +'%Y%m%d_%H%M%S') # История бэкапов ведется, бэкап сохраняется в каталог с меткой времени
# ///////////////////////////////////////////////////////////////

$(dirname ${BASH_SOURCE[0]})/main/backup_dbase.sh $srvname $port $dbname $username $jobs $backupdir_root $backup_suffix
