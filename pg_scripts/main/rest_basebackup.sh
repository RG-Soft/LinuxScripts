#!/bin/bash
#--------------------------------------------------------------------
# Script to restore cluster PostgreSQL on point in time. Linux Ubuntu (22.04)
#
# RGS
# Developed by Aleskandr Seryakov 01.04.2024
#--------------------------------------------------------------------

if (( $# < 6 )); then
  echo "Не верное количество параметров! Проверьте настройки стартера"

else

  echo -n "Проверим что каталог указан корректно ... "
  if [ "$3" = "" ] || [ "$3" != "/pgclusters/pgpro/std-15/data-5433" ]; then
    echo " Ошибка!"
    echo "Parameter PATH_PG_DATA must be filled correct!"
  else
    echo "Корректно!"

    PORT=$1 
    PG_SETUP_NAME=$2
    PATH_PG_DATA=$3
    PATH_TO_FILE_BASEBACKUP=$4
    PATH_TO_FILES_BACKUP_WAL=$5
    ARCHIVE_MODE=$6
    RECOVERY_TARGET=$7

    path_pg_bin=/opt/pgpro/std-15/bin

    echo -n "Останавливаем сервис ... "
    $path_pg_bin/$PG_SETUP_NAME service stop
    echo "Выполнено!"

    sleep 5

    echo -n "Удаляем файлы мз каталога кластера ... "
    if (( ${#PATH_PG_DATA} < 2 )); then
      echo "Ошибка!"
      echo "Слишком короткий путь, проверьте параметр \"PATH_PG_DATA\" ${PATH_PG_DATA}"
      exit
    fi

    rm -rf $PATH_PG_DATA/*
    echo "Выполнено!"

    tar xvfz $PATH_TO_FILE_BASEBACKUP -C $PATH_PG_DATA

    echo "port = $PORT" >> $PATH_PG_DATA/postgresql.auto.conf
    echo "archive_mode = 'off'" >>$PATH_PG_DATA/postgresql.auto.conf
    echo "archive_command = ''" >>$PATH_PG_DATA/postgresql.auto.conf
    echo "recovery_target_action = 'promote'" >>$PATH_PG_DATA/postgresql.auto.conf
    echo "restore_command = 'cp $PATH_TO_FILES_BACKUP_WAL/%f %p'" >>$PATH_PG_DATA/postgresql.auto.conf

    #echo "recovery_target_time = '2024-04-24 16:00:00.000'" >>$PATH_PG_DATA/postgresql.auto.conf
    #echo "recovery_target_time = 'immediate'" >>$PATH_PG_DATA/postgresql.auto.conf

    if [ $# = 7 ]; then
     echo "recovery_target_time = '$RECOVERY_TARGET'" >>$PATH_PG_DATA/postgresql.auto.conf
    else
     echo "recovery_target = 'immediate'" >>$PATH_PG_DATA/postgresql.auto.conf
    fi

    touch $PATH_PG_DATA/recovery.signal
    chmod 600 $PATH_PG_DATA/recovery.signal
    chown postgres:postgres $PATH_PG_DATA/recovery.signal

    $path_pg_bin/$PG_SETUP_NAME service condrestart

    sleep 5

    $path_pg_bin/$PG_SETUP_NAME service status

  fi;

fi;
