#!/bin/bash
#
# RGS Стартер восстановления базы из бэкапа pg_dump в базу
#
#Пример запуска стартера:            ./rest_backup_dbase_name.sh
#Прмиер запуска исполняемого модуля: ./rest_backup_dbase.sh srv01 5432 dbsaler1 postgres 3"

#. Введите имя базы в которую надо залить бэкап. Это имя рабочей базы и фамилия сотрудника
dbname=Zakupki_Ivanov
#. Введите адрес каталога бэкапа
backup_dir=/pgbackup/ru0222app48/Zakupki/Zakupki_now	# Бэкап на рабочем сервере
#backup_dir=/pgbackup/current_backup/now.Z_St		# Бэкап на текущем сервере

srvname=localhost
port=5432
username=postgres
jobs=3

$(dirname ${BASH_SOURCE[0]})/rest_backup_dbase.sh $srvname $port $dbname $username $jobs $backup_dir
