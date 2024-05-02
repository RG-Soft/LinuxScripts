#!/bin/bash
#
# RGS Скрипт для подготовки тайм и сервис модулей регламентов PostgreSQL.
#
#Пример запуска модуля: ./chown_root.sh

for file_u in $(dirname ${BASH_SOURCE[0]})/*.service
do
    file_name=$(basename ${file_u})
    copy_file=/etc/systemd/system/$file_name
    file_present=0

    if [ -f "$filename" ]; then
        systemctl stop $file_name
        file_present=1
    fi

    if cp $file_u $copy_file; then
        chown root:root $copy_file

        if [[ $file_present -eq 1 ]]; then
            systemctl daemon-reload
        fi

        systemctl status $file_name

    fi
done

for file_u in $(dirname ${BASH_SOURCE[0]})/*.timer
do
    file_name=$(basename ${file_u})
    copy_file=/etc/systemd/system/$file_name
    file_present=0

    if [ -f "$filename" ]; then
        systemctl stop $file_name
        systemctl disable $file_name
        file_present=1
    fi

    if cp $file_u $copy_file; then
        chown root:root $copy_file

        if [[ $file_present -eq 1 ]]; then
            systemctl daemon-reload
        fi

        systemctl status $file_name
        systemctl start $file_name
        systemctl enable $file_name

    fi
done
