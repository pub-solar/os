{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.crypto;
in
{
  options.pub-solar.crypto = {
    enable = mkEnableOption "Life in private";
  };

  config = mkIf cfg.enable {
    services.udev.packages = [ pkgs.yubikey-personalization ];
    services.dbus.packages = [ pkgs.gcr ];
    services.pcscd.enable = true;

    services.gnome.gnome-keyring.enable = true;

    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      systemd.user.services.polkit-gnome-authentication-agent = import ./polkit-gnome-authentication-agent.service.nix pkgs;

      services.gpg-agent = {
        enable = true;
        pinentryFlavor = "gnome3";
        verbose = true;
      };

      programs.gpg = {
        enable = true;
      };

      home.packages = [
        gnome3.seahorse
        keepassxc
        libsecret
        qMasterPassword
        restic
      ];
    };
  };
}
