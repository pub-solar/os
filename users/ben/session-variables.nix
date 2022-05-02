{ config, pkgs, ... }:
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
  DRONE_RPC_PROTO = "https";
  DRONE_RPC_HOST = "ci.b12f.io";
in
{
  home-manager = pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
    home.sessionVariables = {
      inherit DRONE_RPC_HOST;
      inherit DRONE_RPC_PROTO;
      DRONE_SERVER = DRONE_RPC_PROTO + "://" + DRONE_RPC_HOST;

      RESTIC_REPOSITORY = "sftp:root@backup.b12f.io:/media/internal/backups";
      RESTIC_PASSWORD_COMMAND = "secret-tool lookup restic repository-password";
    };
  };
}
