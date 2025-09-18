export ICLOUD="~/Library/Mobile\ Documents/com~apple~CloudDocs"

if [ -d "$(eval echo ${ICLOUD//>/})" ]; then
  alias icloud="cd $ICLOUD"
  alias repos="cd $ICLOUD/Work/repos/"
  alias dev="cd $ICLOUD/Work/devel/"
fi

export DROPBOX="$HOME/Dropbox"

# if [ -d $DROPBOX ]; then
# fi

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

###################################

alias ap='ansible-playbook'

db_justified_restore() {
  local date_format="$1"
  local db_name="${2:-justified_prod}"  # defaults to justified_prod if not provided
  
  if [ -z "$date_format" ]; then
      echo "Usage: db_restore_date YYYY-MM-DD [database_name]"
      return 1
  fi
  
  local encrypted_file="$HOME/Downloads/${date_format}.sql.gz.encrypted"
  local decrypted_file="$HOME/Downloads/out-${date_format}.sql.gz"
  
  echo "Decrypting: $encrypted_file"
  ./script/db_backup_decrypt -f "$encrypted_file" || return 1
  
  echo "Restoring to database: $db_name"
  ./script/db_restore restore -f "$decrypted_file" -d "$db_name"
}
