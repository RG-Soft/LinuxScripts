#!/bin/bash
#
# RGS Скрипт для подготовки тайм и сервис модулей регламентов PostgreSQL.
#
#Пример запуска модуля: ./chown_root.sh

for file_u in ./*.service
do
    chown root:root $file_u
    #chmod +x $file_sh
done

for file_u in ./*.timer
do
    chown root:root $file_u
    #chmod +x $file_sh
done
