#!/bin/bash
#
# RGS Скрипт для подготовки скриптов/модулей регламентов PostgreSQL.
#
#Пример запуска модуля: ./chown_x_postgres.sh

for file_sh in `pwd`/*.sh
do
    chown postgres:postgres $file_sh
    chmod +x $file_sh
done
