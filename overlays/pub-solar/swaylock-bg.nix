self: with self; ''
  # Dependencies:
  # swaylock

  # Make sure we aren't running twice
  RUNNING=$(ps -A | grep swaylock | wc -l)
  if [ $RUNNING -ne 0 ]; then
    exit 0
  fi

  IMAGE=$XDG_CONFIG_HOME/wallpaper.jpg
  LOCKARGS=""

  for OUTPUT in `${sway}/bin/swaymsg -t get_outputs | jq -r '.[].name'`
  do
      LOCKARGS="''${LOCKARGS} --image ''${OUTPUT}:''${IMAGE}"
      IMAGES="''${IMAGES} ''${IMAGE}"
  done
  exec ${swaylock}/bin/swaylock $LOCKARGS
''
