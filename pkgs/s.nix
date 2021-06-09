self: with self; ''
  case $1 in
    d)
      shift;
      URL="https://duckduckgo.com?q=$@"
      ;;
    no)
      shift;
      URL="https://search.nixos.org/options?query=$@"
      ;;
    np)
      shift;
      URL="https://search.nixos.org/packages?query=$@"
      ;;
    rs)
      shift;
      URL="https://doc.rust-lang.org/std/index.html?search=$@"
      ;;
    rsc)
      shift;
      URL="https://docs.rs/releases/search?query=$@"
      ;;
    mdn)
      shift;
      URL="https://developer.mozilla.org/en-US/search?q=$@"
      ;;
    w)
      shift;
      URL="https://en.wikipedia.org/w/index.php?search=$@"
      ;;
    *)
      URL="https://search.b12f.io?q=$@"
      ;;
  esac


  ${firefox-wayland}/bin/firefox --new-tab "$URL"
  ${sway}/bin/swaymsg '[app_id="firefox"]' focus
''
