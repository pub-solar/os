{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.social;
in
{
  options.pub-solar.social = {
    enable = mkEnableOption "Life with others";
  };

  config = mkIf cfg.enable {
    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      home.packages = [
        #mySignalDesktop
        signal-desktop
        tdesktop
        element-desktop
        irssi
      ];
    };
  };
}
