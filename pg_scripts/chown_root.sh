#!/bin/bash
#
# RGS Скрипт для подготовки тайм и сервис модулей регламентов PostgreSQL.
#
#Пример запуска модуля: ./chown_root.sh

for file_u in `pwd`/*.service
do
    chown root:root $file_u
    #chmod +x $file_sh
done

for file_u in `pwd`/*.timer
do
    chown root:root $file_u
    #chmod +x $file_sh
done
