self: with self; ''
  exec ${alacritty}/bin/alacritty --class mu_vimpc --option dimensions.columns=120 --option dimensions.lines=80 -e vimpc -- "$@"
''
