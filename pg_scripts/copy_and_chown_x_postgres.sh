#!/bin/bash
#
# RGS Скрипт для подготовки скриптов/модулей регламентов PostgreSQL.
#
#Пример запуска модуля: ./chown_x_postgres.sh

home_pg=~postgres
home_pgscripts="${home_pg}/pg_scripts"

for file_sh in "$(dirname ${BASH_SOURCE[0]})/*.sh"
do
    copy_file="${home_pgscripts}/$(basename ${file_u})"
    cp $file_sh $copy_file
    chown postgres:postgres $file_sh
    chmod +x $file_sh
done

for file_sh in "$(dirname ${BASH_SOURCE[0]})/main/*.sh"
do
    copy_file="${home_pgscripts}/main/$(basename ${file_u})"
    cp $file_sh $copy_file
    chown postgres:postgres $file_sh
    chmod +x $file_sh
done
