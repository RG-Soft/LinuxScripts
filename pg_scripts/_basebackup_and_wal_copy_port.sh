#!/bin/bash
#
# RGS Стартер модуль регламента basebackup и wal файлов кластера для оформления каталога и копирования в "облоко".
#
#Пример запуска модуля:              ./basebackup_and_wal_copy_zakupki.sh
#Прмиер запуска исполняемого модуля: ./basebackup_and_wal_copy.sh Zakupki /pgbackup/Zakupki/walbackup/ /pgbackup/Zakupki/basebackup/ /mnt/nas02_YANDEX/SQLBackup/Zakupki/"

clustername=db_saler # можно использовать номер порта, если кластен не именной, или именя базы кластера.
walbackup_dir=/pgbackup/$clustername/archive/
basebackup_dir=/pgbackup/$clustername/basebackup/
basebackup_cloud_dir=/mnt/nas02_YANDEX/SQLBackup/$clustername/

$(dirname ${BASH_SOURCE[0]})/basebackup_and_wal_copy.sh $clustername $walbackup_dir $basebackup_dir $basebackup_cloud_dir
