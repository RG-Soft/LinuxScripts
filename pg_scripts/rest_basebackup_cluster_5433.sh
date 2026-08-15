#!/bin/bash
#--------------------------------------------------------------------
# Script to start restore_basebackup.sh  restore cluster PostgreSQL with parameters. Linux Ubuntu (22.04)
#
# RGS
# Developed by Aleskandr Seryakov 01.04.2024
#--------------------------------------------------------------------

PORT="5433"
PG_SETUP_NAME="pg-setup-5433"
#PATH_PG_DATA=/pgclusters/pgpro/std-15
PATH_PG_DATA=/pgclusters/pgpro/1c-18/data-5433
if [ ! -d $PATH_PG_DATA ] ; then
    echo "Нет каталога ${PATH_PG_DATA}"
    exit
fi

PATH_TO_FILE_BASEBACKUP=/pgbackup/5433/base.tar.gz
if [ ! -f $PATH_TO_FILE_BASEBACKUP ] ; then
    echo "Нет файла ${PATH_TO_FILE_BASEBACKUP}"
    exit
fi
PATH_TO_FILES_BACKUP_WAL=/pgbackup/5433/walbackup
if [ ! -d $PATH_TO_FILES_BACKUP_WAL ] ; then
    echo "Нет каталога ${PATH_TO_FILES_BACKUP_WAL}"
    exit
fi

#exit

#Параметры: если сервер восстановливается как дополнительный тестовый - "off"
# если восстановливается как продукционный на том же месте или переносится на другой сервер - "on"
ARCHIVE_MODE="off"


# recovery_target_time = 'yyyy-mm-dd hh:mm:ss.sss'
# Если не указан параметр, только восстановить согласованность (до ближайшей точки)
# Восстановление на 1 апреля 2024 г. 12 часов дня
RECOVERY_TARGET="2024-04-24 18:00:00.000"

$(dirname ${BASH_SOURCE[0]})/main/restore_basebackup.sh $PORT $PG_SETUP_NAME $PATH_PG_DATA $PATH_TO_FILE_BASEBACKUP $PATH_TO_FILES_BACKUP_WAL $ARCHIVE_MODE "$RECOVERY_TARGET"
