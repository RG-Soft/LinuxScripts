#!/bin/bash
#
# RGS Стартер восстановления базы из бэкапа pg_dump в базу
#
# Пример запуска стартера:            ./rest_backup_dbase_name.sh
# Пример запуска исполняемого модуля: ./rest_backup_dbase.sh srv01 5432 dbsaler1 postgres 3 /pgbackup/dbsaler1_now"
#-----------------------Часто изменяемые параметры----------------------------
#. Введите имя базы из которой надо залить бэкап. Обычно это имя рабочей базы.
dbname_source=Zakupki
#. Введите фамилию сотрудника для которого надо залить бэкап. Это фамилия сотрудника + возможно номер или другое
developer=Shvedova
#----------------------------------------------------------------------------
#. Уточните адрес каталога бэкапа
backup_dir=/mnt/ru0222app48/${dbname_source}/${dbname_source}_now	# Бэкап на рабочем сервере
#backup_dir=/pgbackup/current_backup/now.Z_St		# Бэкап на текущем сервере
#----------------------------------------------------------------------------

dbname=${dbname_source}_${developer}
srvname=localhost
port=5432
username=postgres
jobs=3 # количество должно быть CPU/2 - максимум на слабых машинах.

$(dirname ${BASH_SOURCE[0]})/main/rest_backup_dbase.sh $srvname $port $dbname $username $jobs $backup_dir
