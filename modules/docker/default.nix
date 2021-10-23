{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.docker;
in
{
  options.pub-solar.docker = {
    enable = mkEnableOption "Life in metal boxes";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users = with pkgs; pkgs.lib.setAttrByPath [ psCfg.user.name ] {
      extraGroups = [ "docker" ];
    };

    environment.systemPackages = with pkgs; [
      docker-compose
      docker-compose_2
    ];
  };
}
