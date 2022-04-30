self: with self; ''
  set -e

  current_layout=$(${sway}/bin/swaymsg -t get_inputs | ${jq}/bin/jq -r '.[] | select(.type == "keyboard") | .xkb_active_layout_index' | head -1)
  total_layouts=$(${sway}/bin/swaymsg -t get_inputs | ${jq}/bin/jq -r '.[] | select(.type == "keyboard") | .xkb_layout_names | length' | head -1)

  next_layout=$(expr $current_layout + 1);

  if [ $next_layout -ge $total_layouts ]; then
    next_layout=0;
  fi

  notify-send "$next_layout"
  ${sway}/bin/swaymsg input '*' xkb_switch_layout "$next_layout"
''
