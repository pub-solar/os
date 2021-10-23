{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.devops;
in
{
  options.pub-solar.devops = {
    enable = mkEnableOption "Life automated";
  };

  config = mkIf cfg.enable {
    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      home.packages = [
        croc
        drone-cli
        nmap
        python38Packages.ansible
        restic
        shellcheck
        terraform_0_15
        tea
      ];
    };
  };
}
