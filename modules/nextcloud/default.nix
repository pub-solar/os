{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.nextcloud;
in
{
  options.pub-solar.nextcloud = {
    enable = mkEnableOption "Life in sync";
  };

  config = mkIf cfg.enable {
    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      systemd.user.services.nextcloud-client = import ./nextcloud.service.nix pkgs;
    };
  };
}
