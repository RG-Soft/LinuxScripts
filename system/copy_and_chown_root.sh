#!/bin/bash
#
# RGS Скрипт для подготовки тайм и сервис модулей регламентов PostgreSQL.
#
#Пример запуска модуля: ./chown_root.sh

for file_u in $(dirname ${BASH_SOURCE[0]})/*.service
do
    copy_file=/etc/systemd/system/$(basename ${file_u})
    cp $file_u $copy_file
    chown root:root $copy_file
done

for file_u in $(dirname ${BASH_SOURCE[0]})/*.timer
do
    copy_file=/etc/systemd/system/$(basename ${file_u})
    cp $file_u $copy_file
    chown root:root $copy_file
done
