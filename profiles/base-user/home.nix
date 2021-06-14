{ config, pkgs, lib, ... }:
with lib;
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
in
{
  imports = [
    ./session-variables.nix
  ];

  home-manager.users = pkgs.lib.setAttrByPath [ psCfg.user.name ] {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = psCfg.user.name;
    home.homeDirectory = "/home/${psCfg.user.name}";

    home.packages = with pkgs; [ ];

    fonts.fontconfig.enable = true;

    programs.dircolors.enable = true;
    programs.dircolors.enableZshIntegration = true;

    home.file."xinitrc".source = ./.xinitrc;

    xdg.enable = true;
    xdg.mime.enable = true;
    xdg.mimeApps = import ./mimeapps.nix;

    xdg.configFile."git/config".text = import ./.config/git/config.nix { inherit config; inherit pkgs; };
    xdg.configFile."dircolors".source = ./.config/dircolors;
    xdg.configFile."xmodmap".source = ./.config/xmodmap;
    xdg.configFile."user-dirs.dirs".source = ./.config/user-dirs.dirs;
    xdg.configFile."user-dirs.locale".source = ./.config/user-dirs.locale;
    xdg.configFile."xsettingsd/xsettingsd.conf".source = ./.config/xsettingsd/xsettingsd.conf;
    xdg.configFile."mako/config".source = ./.config/mako/config;
    xdg.configFile."vifm/vifmrc".source = ./.config/vifm/vifmrc;
    xdg.configFile."vifm/colors/base16.vifm".source = ./.config/vifm/colors/base16.vifm;
    xdg.configFile."libinput-gestures.conf".source = ./.config/libinput-gestures.conf;
    xdg.configFile."waybar/config".source = ./.config/waybar/config;
    xdg.configFile."waybar/style.css".source = ./.config/waybar/style.css;
    xdg.configFile."waybar/colorscheme.css".source = ./.config/waybar/colorscheme.css;
    xdg.configFile."mutt/muttrc".source = ./.config/mutt/muttrc;
    xdg.configFile."mutt/base16.muttrc".source = ./.config/mutt/base16.muttrc;
    xdg.configFile."mutt/mailcap".source = ./.config/mutt/mailcap;
    xdg.configFile."offlineimap/functions.py".source = ./.config/offlineimap/functions.py;
    xdg.configFile."wallpaper.jpg".source = ./assets/wallpaper.jpg;

    # Ensure nvim backup directory gets created
    # Workaround for E510: Can't make backup file (add ! to override)
    xdg.dataFile."nvim/backup/.keep".text = "";

    # Allow unfree packages only on a user basis, not on a system-wide basis
    xdg.configFile."nixpkgs/config.nix".text = " { allowUnfree = true; } ";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "21.03";
  };
}
