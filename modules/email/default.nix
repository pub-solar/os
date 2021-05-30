{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.email;
in
{
  options.pub-solar.email = {
    enable = mkEnableOption "Life in headers";
  };

  config = mkIf cfg.enable {
    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      home.packages = [
        w3m
        urlscan
        neomutt
        offlineimap
        msmtp
        mailto-mutt
      ];

      programs.offlineimap = {
        enable = true;
        pythonFile = builtins.readFile ./offlineimap.py;
      };
    };
  };
}
