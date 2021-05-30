{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.server;
in
{
  options.pub-solar.server = {
    enable = mkEnableOption "Enable server options like sshd";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };
}
