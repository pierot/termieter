if [[ $OS == 'OSX' ]]; then
  # MONGODB
  alias mongo-backup='mongodump --host=127.0.0.1:27017 --out=~/.backups/backups/mongodb/dag-`date +%u`'
  alias mongo-start='mongod run --config /usr/local/Cellar/mongodb/2.2.2-x86_64/mongod.conf --rest'

  # MYSQL
  alias mysql-start='launchctl load /usr/local/Cellar/mysql/5.5.29/homebrew.mxcl.mysql.plist'
  alias mysql-stop='launchctl unload /usr/local/Cellar/mysql/5.5.29/homebrew.mxcl.mysql.plist'
  alias mysql-restart='mysql-stop | mysql-start'

  # POSTGRES
  alias postgresql-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
  alias postgresql-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
  alias posgresql-restart='postgresql-stop | postgresql-start'

  # REDIS
  alias redis-start='redis-server /usr/local/etc/redis.conf'
# else
  # LINUX
fi
