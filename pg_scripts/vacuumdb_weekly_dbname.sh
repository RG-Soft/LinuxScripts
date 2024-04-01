
#
<<<<<<< HEAD
# RGS Стартер еженедельного регламента vacuumdb базы кластера
#
#Пример запуска стартера:            ./vacuumdb_dbname.sh
#Прмиер запуска исполняемого модуля: ./vacuumdb_dbase.sh srv01 5432 DBName postgres 3 freeze"
=======
# RGS Стартер регламента vacuumdb еженедельный базы кластера
#
#Пример запуска стартера:            ./vacuumdb_dbname.sh
#Прмиер запуска исполняемого модуля: ./vacuumdb_dbase.sh srv01 5432 DBName postgres 3"
>>>>>>> 62da157 (Реализован регламент vacuumdb со стартером)

dbname=DBase
srvname=localhost
port=5432
username=postgres
jobs=3
<<<<<<< HEAD
freeze=freeze

./vacuumdb_dbase.sh $srvname $port $dbname $username $jobs $freeze
=======

./vacuumdb_dbase.sh $srvname $port $dbname $username $jobs
>>>>>>> 62da157 (Реализован регламент vacuumdb со стартером)
