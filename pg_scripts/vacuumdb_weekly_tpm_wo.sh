
#
# RGS Стартер ежедневного регламента vacuumdb базы кластера
#
#Пример запуска стартера:            ./vacuumdb_dbname.sh
#Прмиер запуска исполняемого модуля: ./vacuumdb_dbase.sh srv01 5432 DBName postgres 3"

dbname=TPM_WO
srvname=localhost
port=5433
username=postgres
jobs=3
freeze=freeze

/var/lib/postgresql/vacuumdb_dbase.sh $srvname $port $dbname $username $jobs $freeze