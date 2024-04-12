#!/bin/bash
#
# RGS Скрипт для подготовки тайм и сервис модулей регламентов PostgreSQL.
#
#Пример запуска модуля: ./chown_root.sh

for file_u in $(dirname ${BASH_SOURCE[0]})/*.service
do
    chown root:root $file_u
    #chmod +x $file_sh
done

for file_u in $(dirname ${BASH_SOURCE[0]})/*.timer
do
    chown root:root $file_u
    #chmod +x $file_sh
done
