#!/bin/bash
#
# RGS Скрипт для подготовки скриптов/модулей регламентов PostgreSQL.
#
# Пример запуска модуля: ./copy_and_chown_x_postgres.sh

home_pg=~postgres
home_pgscripts=${home_pg}/pg_scripts

for file_sh in $(dirname ${BASH_SOURCE[0]})/*.sh
do
    copy_file=${home_pgscripts}/$(basename ${file_sh})
    cp $file_sh $copy_file
    chown postgres:postgres $copy_file
    chmod +x $copy_file
done

for file_sh in $(dirname ${BASH_SOURCE[0]})/main/*.sh
do
    copy_file=${home_pgscripts}/main/$(basename ${file_sh})
    cp $file_sh $copy_file
    chown postgres:postgres $copy_file
    chmod +x $copy_file
done
