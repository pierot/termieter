alias postgresql-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias postgresql-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias posgresql-restart='postgresql-stop | postgresql-start'
