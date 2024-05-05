#!/bin/bash
#
# RGS Скрипт для подготовки скриптов/модулей регламентов PostgreSQL.
#
#Пример запуска модуля: ./chown_x_postgres.sh

for file_sh in $(dirname ${BASH_SOURCE[0]})/*.sh
do
    chown postgres:postgres $file_sh
    chmod +x $file_sh
done

for file_sh in $(dirname ${BASH_SOURCE[0]})/main/*.sh
do
    chown postgres:postgres $file_sh
    chmod +x $file_sh
done
