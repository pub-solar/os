{ config, pkgs, lib, self, ... }:
with lib;
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
in
{
  imports = [
    ./session-variables.nix
  ];

  home-manager = pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
    home.packages = with pkgs; [
      dogecoin
      nodejs
    ];

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "git.b12f.io" = {
          hostname = "git.b12f.io";
          user = "git";
          port = 2222;
        };

        "aur.archlinux.org" = {
          user = "aur";
        };

        "leavieler.art" = {
          hostname = "web5svsvy.wh.hosting.zone";
          user = "web5svsvy_cgzqa3";
          port = 2244;
        };

        "benjaminbaedorf.eu" = {
          hostname = "web5svsvy.wh.hosting.zone";
          user = "web5svsvy_cgzqa3";
          port = 2244;
        };

        "miom.space" = {
          hostname = "web7dgkba.wh.hosting.zone";
          user = "web7dgkba_c9em8f";
          port = 2244;
        };
      };
    };

    xdg.configFile."mutt/accounts.muttrc".text = ''
      source ./hello@benjaminbaedorf.eu.muttrc

      macro index <f1> '<sync-mailbox><enter-command>source $XDG_CONFIG_HOME/mutt/hello@benjaminbaedorf.eu.muttrc<enter><change-folder>!<enter>'
      macro index <f2> '<sync-mailbox><enter-command>source $XDG_CONFIG_HOME/mutt/benjamin.baedorf@rwth-aachen.de.muttrc<enter><change-folder>!<enter>'
      macro index <f3> '<sync-mailbox><enter-command>source $XDG_CONFIG_HOME/mutt/b.baedorf@openproject.com.muttrc<enter><change-folder>!<enter>'
      macro index <f4> '<sync-mailbox><enter-command>source $XDG_CONFIG_HOME/mutt/byb@miom.space.muttrc<enter><change-folder>!<enter>'
    '';
    xdg.configFile."mutt/hello@benjaminbaedorf.eu.muttrc".source = ./.config/mutt + "/hello@benjaminbaedorf.eu.muttrc";
    xdg.configFile."mutt/benjamin.baedorf@rwth-aachen.de.muttrc".source = ./.config/mutt + "/benjamin.baedorf@rwth-aachen.de.muttrc";
    xdg.configFile."mutt/hello@benjaminbaedorf.eu.signature".source = ./.config/mutt + "/hello@benjaminbaedorf.eu.signature";
    xdg.configFile."mutt/b.baedorf@openproject.com.muttrc".source = ./.config/mutt + "/b.baedorf@openproject.com.muttrc";
    xdg.configFile."mutt/b.baedorf@openproject.com.signature".source = ./.config/mutt + "/b.baedorf@openproject.com.signature";
    xdg.configFile."mutt/byb@miom.space.muttrc".source = ./.config/mutt + "/byb@miom.space.muttrc";
    xdg.configFile."mutt/byb@miom.space.signature".source = ./.config/mutt + "/byb@miom.space.signature";
    xdg.configFile."offlineimap/config".source = ./.config/offlineimap/config;
    xdg.configFile."msmtp/config".source = ./.config/msmtp/config;
    # xdg.configFile."wallpaper.jpg".source = ./assets/wallpaper.jpg;
  };

  age.secrets = pkgs.lib.setAttrByPath [ "mopidy.conf" ] {
    file = "${self}/secrets/mopidy.conf";
    mode = "700";
    owner = "mopidy";
  };
  services.mopidy.extraConfigFiles = [ "/run/secrets/mopidy.conf" ];
}
