#!/bin/bash
#
# RGS Исполняемый модуль регламента basebackup и wal файлов кластера для оформления каталога и копирования в "облоко".
#
# Пример запуска модуля:              ./basebackup_and_wal_copy_zakupki.sh
# Прмиер запуска исполняемого модуля: ./basebackup_and_wal_copy.sh Zakupki /pgbackup/Zakupki/walbackup/ /pgbackup/Zakupki/basebackup/ /mnt/nas02_YANDEX/SQLBackup/Zakupki/"

USAGE_STRING="Использовать: $0 clastername walbackup_dir basebackup_dir basebackup_cloud_dir
Пример: ./basebackup_and_wal_copy.sh 5432 /pgbackup/5432/walbackup/ /pgbackup/5432/basebackup/ /mnt/nas02_YANDEX/SQLBackup/5432/"

if [ "$1" == "" ]; then
    echo "$USAGE_STRING"
    exit
fi

clustername=$1 # можно использовать номер порта, если кластен не именной, или именя базы кластера.
walbackup_dir=$2
basebackup_dir=$3
basebackup_cloud_dir=$4

basebackup_current_dir=""
#pgbasebackup_cloud_current_dir=/mnt/ru0222nas02_YANDEX/ru0994app40/SQLBackup/$clustername/???

IFS=""
echo -n "Необходимо проверить сбой прошлого копирования и докопировать в облако ... "
if cd "$basebackup_dir" ; then
	mapfile -t dirlist < <( find . -maxdepth 1 -mindepth 1 -name "${clustername}_*" -type d -printf '%f\n' | sort )
	echo 
	echo "Директории в обработке: "${dirlist[@]}
	for basebackup_current_dir in ${dirlist[@]}; do

		mapfile -t filelist < <( find "$basebackup_current_dir" -maxdepth 1 -mindepth 1 -regex ".*/[0-9A-F]+\.[0-9A-F]+\.backup" -type f -printf '%f\n' | sort )
		echo 
		echo "Файлы с метками basebackup: "${filelist[@]}
		for file in ${filelist[@]}; do
			echo "Найден подготовленный каталог!"
			echo "Каталог basebackup: ${basebackup_current_dir} содержит файлы WAL. Файл с меткой $(basename ${file})"
			cat "${basebackup_current_dir}/${file}"
			echo -n "Проверяем архив basebackup+wall в облаке ${basebackup_cloud_dir}... "
			if [ -f "$basebackup_cloud_dir"/"$basebackup_current_dir" ] ; then
				echo "Существует архив в облаке!"
				echo -n "Удаляем файлы ... "
				if rm -R "$basebackup_cloud_dir"/"$basebackup_current_dir" ; then
					echo "Выполнено!"
				else
					echo "ОШИБКА!!!"
					echo "Ошибка при очистке каталога в облаке файлов! Необходима проверка"
					exit
				fi
			fi

			echo -n "Перемещаем файлы  basebackup+wall в облако ${basebackup_cloud_dir}... "
			#if mv "$basebackup_current_dir" "$basebackup_cloud_dir"
			if tar -zcvf "$basebackup_cloud_dir"/"$basebackup_current_dir"".tar.gz" "$basebackup_current_dir"
			then
				if ! rm -R "$basebackup_current_dir" ; then
					echo "ОШИБКА!!!"
					echo "Ошибка при очистке каталога \"${basebackup_current_dir}\"! Необходима проверка"
					exit
				fi
				
				echo "Выполнено!"
				exit
				
			else
				echo "ОШИБКА!!!"
				echo "Ошибка при перемещении файлов! Необходима проверка"
				exit
			fi
		done
		# Проверяем только первый по списку каталог
		break
	done
else
	echo "Ошибка!!!" 
	echo "Не удалось перейти в каталог basebackup: ${basebackup_dir}. Прервано копирование в облако!"
	echo
	exit 
fi

basebackup_current_dir=""
current_name=""
finish_name=""
for_index=0

cd "$walbackup_dir"
mapfile -t filelist < <( find . -maxdepth 1 -mindepth 1 -regex ".*/[0-9A-F]+\.[0-9A-F]+\.backup" -type f -printf '%f\n' | sort )
echo 
echo ${filelist[@]}
for file in ${filelist[@]}; do

    echo "-=Processing ${file} итерация ${for_index}=-"

    if [ -f "${file}" ]
    then

		# ext="${file#*.}"
		# echo "extention $ext"
		# echo "file \"$ext\" finded!"

		# echo "test1 ${file#*.}  - расширение за первой точкой слева"
		# echo "test2 ${file##*.} - расширение за последней точкой справа"
		# echo "test3 ${file%*.}  - имя файла с расшиерением"
		# echo "test4 ${file%%.*}  - имя файла без расширения"

		if [ "$for_index" -eq 0 ] ; then
			echo "Первый проход с basebackup $file"
			current_name=${file%%.*}
			current_ext=${file##*.}
			if [ "$current_ext" == "backup" ] ; then
				basebackup_current_dir="$basebackup_dir${clustername}_$(date -r $file +'%Y%m%d')"
				if [ -d "$basebackup_current_dir" ] ; then
					echo "Определен каталог basebackup $basebackup_current_dir"
				else
					echo "ОШИБКА определения каталога. Каталог basebackup ${basebackup_current_dir} не найден!"
					exit
				fi
			fi
		else
			echo "Второй проход с basebackup ${file}"
			finish_name=${file%%.*}
			echo "СТОП Имя файла бэкапа следующего цикла ${finish_name}"
			break
		fi
    fi
    let "for_index++"

done

if [ -z "$finish_name" ]; then
	echo
	echo "ОШИБКА! Не предусмотрена архивация единственного basebackup + wal архивов."
	echo "ОШИБКА! Необходимо сделать basebackup и после завершения повторить текущую операцию."
	exit
fi

let "for_index=0"

for current_file in ${walbackup_dir}* ; do

    current_name=$(basename ${current_file})
    #echo "Итерация копирования с текущим файлом ${current_file}"

    if (( "$for_index" > 0 )) ; then
		echo "Контроль на метку следующего basebackup и останов копирования:"
		current_ext=${current_file##*.}
		if [ "$current_ext" == "backup" ] ; then
			cat ${current_file}
		else
			echo "Контроль НЕ пройден на метку basebackup для файла $finish_name"
			exit
		fi
		break
    fi

    if [[ "${current_name%%.*}" < "$finish_name" ]] ; then
        echo -n "Перемещается файл ${current_name} в ${basebackup_current_dir}/ ... "
		if mv "$current_file" "${basebackup_current_dir}/"
		then
			echo "Выполнено!"
		else
			echo "ОШИБКА!"
			echo "Файл ${current_file} - необходимо проверить результат и каталоги..."
		fi
    else
		echo "Достигли следующего basebackup на дату $(date -r $current_file)"
		echo "Текущий файл ${current_file} и имя целевого ${finish_name}"
        let "for_index++"
		#break
    fi

done

echo -n "Перемещаем файлы  basebackup+wall в облако ${basebackup_cloud_dir}... "
dest_dirname=$(basename ${basebackup_current_dir})
#echo "dest_dirname= ${dest_dirname}"
#exit

echo -n "Проверяем архив basebackup+wall в облаке ${basebackup_cloud_dir}... "
if [ -f "$basebackup_cloud_dir"/"$dest_dirname" ] ; then
	echo "Существует архив в облаке!"
	echo -n "Удаляем файлы ... "
	if rm -R "$basebackup_cloud_dir"/"$dest_dirname" ; then
		echo "Выполнено!"
	else
		echo "ОШИБКА!!!"
		echo "Ошибка при очистке каталога в облаке файлов! Необходима проверка"
		exit
	fi
fi


#if mv "$basebackup_current_dir" "$basebackup_cloud_dir"
if tar -zcvf "$basebackup_cloud_dir"/"$dest_dirname"".tar.gz" "$basebackup_current_dir"
then
	if ! rm -R "$basebackup_current_dir" ; then
		echo "ОШИБКА!!!"
		echo "Ошибка при очистке каталога \"${basebackup_current_dir}\"! Необходима проверка"
		exit
	fi
	echo "Выполнено!"
else
	echo "ОШИБКА!!!"
	echo "Ошибка при перемещении файлов! Необходима проверка"
	exit
fi
