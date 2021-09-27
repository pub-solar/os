{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.mobile;
in
{
  options.pub-solar.mobile = {
    enable = mkEnableOption "Add android adb and tooling";
  };

  config = mkIf cfg.enable {
    programs.adb.enable = true;

    users.users = with pkgs; lib.setAttrByPath [ psCfg.user.name ] {
      extraGroups = [ "adbusers" ];
    };
  };
}
