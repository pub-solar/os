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

  home-manager = pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
    home.packages = with pkgs; [
      dogecoin
    ];

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "git.b12f.io" = {
          hostname = "git.b12f.io";
          port = 2222;
          user = "git";
        };

        "aur.archlinux.org" = {
          user = "aur";
        };
      };
    };

    xdg.configFile."mutt/accounts.muttrc".text = ''
      source ./hello@benjaminbaedorf.eu.muttrc

      macro index <f1> '<sync-mailbox><enter-command>source $XDG_CONFIG_HOME/mutt/hello@benjaminbaedorf.eu.muttrc<enter><change-folder>!<enter>'
      macro index <f2> '<sync-mailbox><enter-command>source $XDG_CONFIG_HOME/mutt/benjamin.baedorf@rwth-aachen.de.muttrc<enter><change-folder>!<enter>'
      macro index <f3> '<sync-mailbox><enter-command>source $XDG_CONFIG_HOME/mutt/b.baedorf@openproject.com.muttrc<enter><change-folder>!<enter>'
    '';
    xdg.configFile."mutt/hello@benjaminbaedorf.eu.muttrc".source = ./.config/mutt + "/hello@benjaminbaedorf.eu.muttrc";
    xdg.configFile."mutt/benjamin.baedorf@rwth-aachen.de.muttrc".source = ./.config/mutt + "/benjamin.baedorf@rwth-aachen.de.muttrc";
    xdg.configFile."mutt/hello@benjaminbaedorf.eu.signature".source = ./.config/mutt + "/hello@benjaminbaedorf.eu.signature";
    xdg.configFile."mutt/b.baedorf@openproject.com.muttrc".source = ./.config/mutt + "/b.baedorf@openproject.com.muttrc";
    xdg.configFile."mutt/b.baedorf@openproject.com.signature".source = ./.config/mutt + "/b.baedorf@openproject.com.signature";
    xdg.configFile."offlineimap/config".source = ./.config/offlineimap/config;
    xdg.configFile."msmtp/config".source = ./.config/msmtp/config;
    # xdg.configFile."wallpaper.jpg".source = ./assets/wallpaper.jpg;
  };

  services.mopidy.configuration = mkIf config.pub-solar.audio.enable (builtins.readFile ./secrets/mopidy.conf);
}