# COLORS + PROMPT
######################################################################################################

SCM_THEME_PROMPT_DIRTY=' ✗ '
SCM_THEME_PROMPT_CLEAN=' ✓ '

# SEP='∴ '
SEP='⚡ '

GIT='git'
SCM_GIT_CHAR='⚒ '

HG='hg'
SCM_HG_CHAR='⚓ '

SVN='svn'
SCM_SVN_CHAR='☢ '

black="\[\e[0;30m\]"
red="\[\e[0;31m\]"
green="\[\e[0;32m\]"
yellow="\[\e[0;33m\]"
blue="\[\e[0;34m\]"
purple="\[\e[0;35m\]"
cyan="\[\e[0;36m\]"
white="\[\e[1;37m\]"
orange="\[\e[33;40m\]"

bold_black="\[\e[1;30m\]"
bold_red="\[\e[1;31m\]"
bold_green="\[\e[1;32m\]"
bold_yellow="\[\e[1;33m\]"
bold_blue="\[\e[1;34m\]"
bold_purple="\[\e[1;35m\]"
bold_cyan="\[\e[1;36m\]"
bold_white="\[\e[1;37m\]"
bold_orange="\[\e[1;33;40m\]"

underline_black="\[\e[4;30m\]"
underline_red="\[\e[4;31m\]"
underline_green="\[\e[4;32m\]"
underline_yellow="\[\e[4;33m\]"
underline_blue="\[\e[4;34m\]"
underline_purple="\[\e[4;35m\]"
underline_cyan="\[\e[4;36m\]"
underline_white="\[\e[4;37m\]"
underline_orange="\[\e[4;33;40m\]"

background_black="\[\e[40m\]"
background_red="\[\e[41m\]"
background_green="\[\e[42m\]"
background_yellow="\[\e[43m\]"
background_blue="\[\e[44m\]"
background_purple="\[\e[45m\]"
background_cyan="\[\e[46m\]"
background_white="\[\e[47m\]"

normal="\[\e[00m\]"
reset_color="\[\e[39m\]"

function scm {
  if [[ -d .git ]]; then SCM=$GIT
  elif [[ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]]; then SCM=$GIT
  elif [[ -d .hg ]]; then SCM=$HG
  elif [[ -n "$(hg root 2> /dev/null)" ]]; then SCM=$HG
  elif [[ -d .svn ]]; then SCM=$SVN
  else SCM='NONE'
  fi
}

function scm_char {
  if [[ -z $SCM ]]; then scm; fi
  [[ $SCM == $GIT ]] && echo $SCM_GIT_CHAR && return
  [[ $SCM == $HG ]] && echo $SCM_HG_CHAR && return
  [[ $SCM == $SVN ]] && echo $SCM_SVN_CHAR && return
  echo ''
}

function scm_prompt_info {
  if [[ -z $SCM ]]; then scm; fi
  [[ $SCM == $GIT ]] && git_prompt_info && return
  [[ $SCM == $HG ]] && hg_prompt_info && return
  [[ $SCM == $SVN ]] && svn_prompt_info && return
}

function parse_ruby_version {
  if [ -s "$HOME/.rvm/scripts/rvm" ]; then
    if [ "$(rvm-prompt i v)" != "" ]; then 
      echo "$(rvm-prompt i v) $SEP"
    fi
  fi

  if [[ -n $(rbenv version 2> /dev/null) ]]; then
    echo "`rbenv version | sed -e 's/ .*//'` $SEP"
  fi
}

function git_prompt_info {
  if [[ -n $(git status -s 2> /dev/null |grep -v ^# |grep -v "working directory clean") ]]; then
    state=$SCM_THEME_PROMPT_DIRTY
  else
    state=$SCM_THEME_PROMPT_CLEAN
  fi

  ref=$(git symbolic-ref HEAD 2> /dev/null) || return

  echo -e "$SCM_GIT_CHAR${ref#refs/heads/}$state"
}

function svn_prompt_info {
  if [[ -n $(svn status 2> /dev/null) ]]; then
    state=$SCM_THEME_PROMPT_DIRTY
  else
    state=$SCM_THEME_PROMPT_CLEAN
  fi

  ref=$(svn info 2> /dev/null | awk -F/ '/^URL:/ { for (i=0; i<=NF; i++) { if ($i == "branches" || $i == "tags" ) { print $(i+1); break }; if ($i == "trunk") { print $i; break } } }') || return

  [[ -z $ref ]] && return
  echo -e "$SCM_SVN_CHAR$ref$state"
}

function hg_prompt_info() {
  if [[ -n $(hg status 2> /dev/null) ]]; then
    state=$SCM_THEME_PROMPT_DIRTY
  else
    state=$SCM_THEME_PROMPT_CLEAN
  fi

  branch=$(hg summary 2> /dev/null | grep branch | awk '{print $2}')
  changeset=$(hg summary 2> /dev/null | grep parent | awk '{print $2}')

  echo -e "$SCM_HG_CHAR$branch:${changeset#*:}$state"
}

PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${DIR:0:11} = "/Volumes/data" ]; then DIR=${DIR:11:${#DIR}-11}; fi; if [ ${#DIR} -gt 26 ]; then CurDir=${DIR:0:10}..${DIR:${#DIR}-13}; else CurDir=$DIR; fi;' 

# PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 27 ]; then CurDir=${DIR:0:10}...${DIR:${#DIR}-10}; else CurDir=$DIR; fi;' 

PS1="\[\033]0;\${DIR:${#DIR}-12}\007$green$(parse_ruby_version)$reset_color$red\u $SEP$reset_color$blue\$CurDir $cyan\$(scm_prompt_info)$reset_color$SEP$normal"
PS1="\[\033[G\]$PS1" # http://jonisalonen.com/2012/your-bash-prompt-needs-this/?utm_source=hackernewsletter&utm_medium=email
