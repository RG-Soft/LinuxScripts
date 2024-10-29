#!/bin/bash
#
# RGS Стартер восстановления базы из бэкапа pg_dump в базу
#
# Пример запуска стартера:            ./rest_backup_dbase_name.sh
# Пример запуска исполняемого модуля: ./rest_backup_dbase.sh srv01 5432 dbsaler1 postgres 3 /pgbackup/dbsaler1_now"
#-----------------------Часто изменяемые параметры----------------------------
#. Введите имя базы из которой надо залить бэкап. Обычно это имя рабочей базы.
dbname_source=CIET_CAS
#. Введите фамилию сотрудника для которого надо залить бэкап. Это фамилия сотрудника + возможно номер или другое
developer=QA
#----------------------------------------------------------------------------
#. Уточните адрес каталога бэкапа
#backup_dir=/mnt/ru0222app48/ru0222app61/${dbname_source}_now	# Бэкап на рабочем сервере
backup_dir=/pgbackup/${dbname_source}/${dbname_source}_now		# Бэкап на текущем сервере
#----------------------------------------------------------------------------

dbname=${dbname_source}_${developer}
#dbname=${dbname_source}
srvname=localhost
port=5433
username=postgres
jobs=3 # количество должно быть CPU/2 - максимум на слабых машинах.

$(dirname ${BASH_SOURCE[0]})/main/rest_backup_dbase.sh $srvname $port $dbname $username $jobs $backup_dir
