{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.graphical;
  yamlFormat = pkgs.formats.yaml { };
  recursiveMerge = attrList:
    let f = attrPath:
      zipAttrsWith (n: values:
        if tail values == [ ]
        then head values
        else if all isList values
        then unique (concatLists values)
        else if all isAttrs values
        then f (attrPath ++ [ n ]) values
        else last values
      );
    in f [ ] attrList;
in
{
  options.pub-solar.graphical = {
    enable = mkEnableOption "Life in color";
    alacritty = {
      settings = mkOption {
        type = yamlFormat.type;
        default = { };
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.opengl.enable = true;
    environment = {
      systemPackages = with pkgs; [
        gtk-engine-murrine
        gtk_engines
        gsettings-desktop-schemas

        matcha-gtk-theme
        papirus-maia-icon-theme

        glib
      ];
      etc = {
        "xdg/PubSolar.conf".text = ''
          [Qt]
          style=GTK+
        '';
      };
    };

    services.getty.autologinUser = "${psCfg.user.name}";

    qt5 = {
      enable = true;
      platformTheme = "gtk2";
      style = "gtk2";
    };

    # Required for running Gnome apps outside the Gnome DE, see https://nixos.wiki/wiki/GNOME#Running_GNOME_programs_outside_of_GNOME
    programs.dconf.enable = true;
    services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];
    # Enable Sushi, a quick previewer for nautilus
    services.gnome.sushi.enable = true;
    # Enable GVfs, a userspace virtual filesystem
    services.gvfs.enable = true;

    fonts.enableDefaultFonts = true;
    fonts.fonts = with pkgs; [
      corefonts
      fira-code
      fira-code-symbols
      google-fonts
      lato
      montserrat
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      open-sans
      powerline-fonts
      source-sans-pro
    ];

    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      home.packages = [
        alacritty
        chromium
        firefox-wayland

        flameshot
        libnotify
        gnome3.adwaita-icon-theme
        gnome.eog
        gnome3.nautilus
        gnome.yelp

        wine

        toggle-kbd-layout

        wcwd

        vlc

        gimp
      ];

      xdg.configFile."alacritty/alacritty.yml" = {
        source = yamlFormat.generate "alacritty.yml" (recursiveMerge [ (import ./alacritty.nix) cfg.alacritty.settings ]);
      };

      gtk = {
        enable = true;
        font.name = "Lato";
        iconTheme = {
          package = pkgs.papirus-maia-icon-theme;
          name = "Papirus-Adapta-Nokto-Maia";
        };
        theme = {
          package = pkgs.matcha-gtk-theme;
          name = "Matcha-dark-aliz";
        };

        gtk3.extraConfig = {
          gtk-xft-antialias = "1";
          gtk-xft-hinting = "1";
          gtk-xft-hintstyle = "hintfull";
          gtk-xft-rgba = "rgb";
          gtk-application-prefer-dark-theme = "true";
        };

      };

      # Fix KeepassXC rendering issue
      # https://github.com/void-linux/void-packages/issues/23517
      systemd.user.sessionVariables.QT_AUTO_SCREEN_SCALE_FACTOR = "0";

      xresources.extraConfig = builtins.readFile ./.Xdefaults;

      systemd.user.services.network-manager-applet = import ./network-manager-applet.service.nix pkgs;
    };
  };
}
