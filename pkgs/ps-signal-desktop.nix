self: with self; ''
  exec ${signal-desktop}/bin/signal-desktop --disable-gpu -- "$@"
''
