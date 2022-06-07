export ICLOUD="~/Library/Mobile\ Documents/com~apple~CloudDocs"

if [ -d "`eval echo ${ICLOUD//>}`" ]; then
  alias icloud="cd $ICLOUD"
  alias repos="cd $ICLOUD/Work/repos/"
  alias dev="cd $ICLOUD/Work/devel/"
fi

export DROPBOX="~/Dropbox"

if [ -d $DROPBOX ]; then
fi

###################################

alias ap='ansible-playbook'

# Login via root and no password
dockr-mysql() {
  docker rm mysql
  docker run \
    -d \
    -v "/Users/pieterm/Work/mysql/data":/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD= \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
    -p 3306:3306 \
    --name mysql \
    --platform linux/x86_64/v8 \
    mysql:8.0.27
}

dockr-postgresql() {
  docker rm postgresql
  docker run \
    -d \
    -v "/Users/pieterm/Work/postgresql/data":/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD= \
    -e POSTGRES_USER=jackjoe \
    -e POSTGRES_HOST_AUTH_METHOD=trust \
    -p 5432:5432 \
    --name postgresql \
    --platform linux/x86_64/v8 \
    postgres:14
}
