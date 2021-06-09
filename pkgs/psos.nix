self: with self; ''
  case $1 in
    rebuild)
      shift;
      exec sudo nixos-rebuild switch --flake "/etc/nixos#installed-host" $@
      ;;
    update)
      shift;
      cd /etc/nixos
      git pull
      exec nix flake update
      ;;
    option)
      shift;
      exec nixos-option -I nixpkgs=/etc/nixos/lib/compat $@
      ;;
    *)
      if [[ "$@" != "" ]]; then
        echo "Unknown command: psos $@"
        echo ""
      fi
      echo "Usage: psos [COMMAND]"
      echo "  rebuild                   Rebuild the configuration and switch to it"
      echo "  update                    Pull git and update flake.lock"
      echo "  option [path]             See the current value for an option in the flake config. Example: psos option nix.nixPath"
      exit 1
      ;;
  esac
''
