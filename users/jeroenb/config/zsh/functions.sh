#!/bin/zsh

have() {
  type "$1" &> /dev/null
}

function cd {
  builtin cd "$@" && exa -l
}

function sloc {
  git ls-files | egrep '\.erl|\.exs?|\.tsx?$' | xargs cat | sed '/^$/d' | sed '/^\s*#/d' | wc -l
}

function sloc_elixir {
  git ls-files | egrep '\.erl|\.exs?$' | xargs cat | sed '/^$/d' | sed '/^\s*#/d' | wc -l
}

function sloc_js {
  git ls-files | egrep '\.jsx?$' | xargs cat | sed '/^$/d' | sed '/^\s*#/d' | wc -l
}

function sloc_ts {
  git ls-files | egrep '\.tsx?$' | xargs cat | sed '/^$/d' | sed '/^\s*#/d' | wc -l
}

function justified_gwt_init {
  cp ../../../.env .env
  cp -R ../../../priv/cert priv/cert
  mix phx.gen.secret
  mix deps.get
  pnpm install
  make styles
}

function take {
  mkdir -p $1
  cd $1
}
