self: with self; ''
  echo "$@" >> $XDG_CACHE_HOME/log/mailto.log

  exec ${alacritty}/bin/alacritty -e neomutt -- "$@"
''
