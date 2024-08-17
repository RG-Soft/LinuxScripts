#!/bin/bash
#
# RGS Скрипт для подготовки скриптов/модулей регламентов PostgreSQL.
#
# Пример запуска модуля: ./copy_and_chown_x_postgres.sh

#shopt -s nullglob # Для простой выборки файлов в случае пустого списка (пустой каталог)

home_pg=~postgres
home_pgscripts="${home_pg}"/pg_scripts
dev_pgscripts="$(dirname ${BASH_SOURCE[0]})"

echo -n "Проверяем есть ли каталог скриптов в '$home_pg' ... "
if [ ! -d "$home_pgscripts" ]; then
    echo "Отсутвствует!"
    if mkdir -p "$home_pgscripts"/main/ ; then
        chown -R postgres:postgres "$home_pgscripts"
        echo "Создан каталог 'pg_scripts/'"
        echo "Создан каталог 'pg_scripts/main/'"
    else
        echo "Ошибка при создании каталога '$home_pgscripts/main'"
        exit
    fi
else
    echo "Существует!"
fi

#for file_sh in $(dirname ${BASH_SOURCE[0]})/*.sh
for file_sh in $( find "$dev_pgscripts" -maxdepth 1 -type f -name '*.sh' | sort )
do
    copy_file="${home_pgscripts}"/"$(basename ${file_sh})"
    cp -bvu -S .bak "$file_sh" "$copy_file"
    chown postgres:postgres "$copy_file"
    chmod +x "$copy_file"
done

#for file_sh in $(dirname ${BASH_SOURCE[0]})/main/*.sh
for file_sh in $( find "$dev_pgscripts"/main -maxdepth 1 -type f -name '*.sh' | sort )
do
    copy_file="${home_pgscripts}"/main/"$(basename ${file_sh})"
    cp -bvu -S .bak "$file_sh" "$copy_file"
    chown postgres:postgres "$copy_file"
    chmod +x "$copy_file"
done

# уберем исполнение для бэкапов
for file_bak in $( find "$home_pgscripts" -maxdepth 2 -type f -name '*.bak' | sort )
do
    chmod -x "$file_bak"
done
