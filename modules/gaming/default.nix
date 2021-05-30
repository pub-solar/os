{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.gaming;
in
{
  options.pub-solar.gaming = {
    enable = mkEnableOption "Life in shooters";
  };

  config = mkIf cfg.enable {
    programs.steam.enable = true;
    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override { };
    };

    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      home.packages = [
        playonlinux
        godot
      ];
    };
  };
}
