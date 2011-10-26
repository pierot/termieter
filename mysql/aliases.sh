alias mysql-start='launchctl load /usr/local/Cellar/mysql/5.5.12/com.mysql.mysqld.plist'
alias mysql-stop='launchctl unload /usr/local/Cellar/mysql/5.5.12/com.mysql.mysqld.plist'
alias mysql-restart='mysql-stop | mysql-start'
