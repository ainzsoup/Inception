if [ -d "/run/mysqld" ]; then
  chown -R mysql:mysql /run/mysqld
else
  mkdir -p /run/mysqld
  chown -R mysql:mysql /run/mysqld
fi

if [ -d /var/lib/mysql/mysql ]; then
  chown -R mysql:mysql /var/lib/mysql
else
  chown -R mysql:mysql /var/lib/mysql
  mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

  tfile=`mktemp`
  if [ ! -f "$tfile" ]; then
    return 1
  fi

  cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF
  echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;" >> $tfile
  echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> $tfile
  echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* to '$MYSQL_USER'@'%';" >> $tfile

  /usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile
  rm -f $tfile
fi

exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0 
