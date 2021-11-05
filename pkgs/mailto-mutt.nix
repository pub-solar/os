self: with self; ''
  mkdir -p $XDG_CACHE_HOME/log

  LOGFILE=$XDG_CACHE_HOME/log/mailto.log
  echo "$@" >> $LOGFILE

  EDITOR=/etc/profiles/per-user/$USER/bin/nvim

  ${alacritty}/bin/alacritty -e neomutt -- "$@"
''
