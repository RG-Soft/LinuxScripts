#!/bin/bash
#
# RGS Скрипт для подготовки тайм и сервис модулей регламентов PostgreSQL.
#
#Пример запуска модуля: ./chown_root.sh

need_reload_config=0

dev_pgscripts="$(dirname ${BASH_SOURCE[0]})"
need_reload_config=0

#shopt -s nullglob
#for file_u in $(dirname ${BASH_SOURCE[0]})/*.service
for file_u in $( find "$dev_pgscripts" -maxdepth 1 -type f -name '*.service' | sort )
do
    echo "Обрабатывается файл сервис юнита $file_u"

    file_name=$(basename ${file_u})
    copy_file=/etc/systemd/system/$file_name
    service_file_present=0

    if [ -f "$copy_file" ]; then
        echo -n "Найден сервис юнит $file_name! ... "
		let "need_reload_config++"
        service_file_present=1

        # 0 - program is running or service is OK
        # 3 - program is not running (файл сервиса есть, но сервис не enabled)
        if [[ `systemctl status $file_name --no-pager 1>/dev/null` -ne 0 ]]; then
            echo -n "Статус enabled или running! Ошибочное состояние. Деактивируем ... "
            systemctl stop $file_name # на всякий случай
            echo -n "Остановлена... "
            systemctl disable $file_name #такой юнит не должен быть enable
            echo "Выключена."
        else
            echo "Статус disbled или not running!"
        fi
    fi

    if cp "$file_u" "$copy_file"; then
        echo "Юнит скопирован в каталог system"
        chown root:root $copy_file

        #if [[ $service_file_present -eq 1 ]]; then
        #    echo -n "Файл юнита был ранее в system, будет перезагружена конфигурация systemd ... "
        #    systemctl daemon-reload
        #    echo "Выполнено!"
        #fi
    else
        echo "Ошибка копирования юнита сервиса ${copy_file}..."
    fi
    echo
done

#shopt -s nullglob
#for file_u in $(dirname ${BASH_SOURCE[0]})/*.timer
for file_u in $( find "$dev_pgscripts" -maxdepth 1 -type f -name '*.timer' | sort )
do
    echo "Обрабатывается файл тайм юнита $file_u"

    file_name=$(basename ${file_u})
    copy_file=/etc/systemd/system/$file_name
    timer_file_present=0
    service_active=0

    if [ -f "$copy_file" ]; then
        echo -n "Найден тайм юнит $file_name! ... "
		let "need_reload_config++"
        timer_file_present=1

        # 0 - program is running or service is OK
        # 3 - program is not running (файл сервиса есть, но сервис не enabled)
        if [[ `systemctl status $file_name --no-pager 1>/dev/null` -eq 0 ]]; then
            echo "Статус enabled или running! Нормальное состояние таймер юнита"
            service_active=1
        else
            echo "Статус disbled или not running!"
        fi
    fi

    if cp "$file_u" "$copy_file"; then
        echo "Юнит скопирован в каталог system"
        chown root:root "$copy_file"

        if [[ $timer_file_present -eq 1 ]]; then
            echo "Файлы юнитов были ранее в system, будет перезагружена конфигурация systemd"
			let "need_reload_config++"
        else
            echo -n "Запускаем и активируем (enable, start) тайм юнит ... "
            systemctl enable $file_name
            echo -n "Включена ... "
            systemctl start $file_name
            echo "Запущена."
            if [[ `systemctl status $file_name --no-pager 1>/dev/null` -ne 0 ]]; then
                echo "Ошибка! Тайм юниту не установлен enable статус."
            fi
        fi
    else
        echo "Ошибка копирования юнита таймера ${copy_file}..."
    fi
    echo
done
