export ICLOUD="~/Library/Mobile\ Documents/com~apple~CloudDocs"

if [ -d "`eval echo ${ICLOUD//>}`" ]; then
  alias icloud="cd $ICLOUD"
  alias repos="cd $ICLOUD/Work/repos/"
  alias dev="cd $ICLOUD/Work/devel/"
fi

export DROPBOX="~/Dropbox"

if [ -d $DROPBOX ]; then
fi

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

###################################

alias ap='ansible-playbook'

# Login via root and no password
# dockr-mysql() {
#     # -v "/opt/homebrew/var/mysql":/var/lib/mysql \
#     # -v mysql:/var/lib/mysql \
#     # --platform linux/x86_64/v8 \
#   docker rm mysql
#   docker volume create --name mysql
#   docker run \
#     -d \
#     -v mysql:/var/lib/mysql \
#     -e MYSQL_ROOT_PASSWORD= \
#     -e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
#     -p 3306:3306 \
#     --name mysql \
#     --platform linux/arm64 \
#     mysql:8.0.29-oracle
# }

podman-mysql() {
  # --security-opt label=disable \
  # -u root \
  # --privileged \
  # --userns keep-id \
    # --platform linux/arm64 \
    # -v "/opt/homebrew/var/mysql":/var/lib/mysql \
  podman rm mysql
  podman run \
    --log-level=debug \
    -d \
    --rm \
    -e MYSQL_ROOT_PASSWORD= \
    -e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
    -p 3306:3306 \
    --name mysql \
    mysql:8.0.29-oracle
}

# dockr-postgresql() {
#   docker rm postgresql
#   docker run \
#     -d \
#     -v "/Users/pieterm/Work/postgresql/data":/var/lib/postgresql/data \
#     -e POSTGRES_PASSWORD= \
#     -e POSTGRES_USER=jackjoe \
#     -e POSTGRES_HOST_AUTH_METHOD=trust \
#     -p 5432:5432 \
#     --name postgresql \
#     --platform linux/x86_64/v8 \
#     postgres:14
# }
