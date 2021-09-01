{ config, pkgs, ... }:
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
in
{
  home-manager = pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
    home.sessionVariables = {
      DRONE_SERVER = "https://ci.b12f.io";
      RESTIC_REPOSITORY = "sftp:root@backup.b12f.io:/media/internal/backups";
      RESTIC_PASSWORD_COMMAND = "secret-tool lookup restic repository-password";
    };
  };
}
