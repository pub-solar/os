{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.pub-solar;
in
{
  options.pub-solar = {
    user = {
      name = mkOption {
        description = "User login name";
        type = types.nullOr types.str;
        default = "nixos";
      };
      password = mkOption {
        description = "User password";
        type = types.nullOr types.str;
        default = null;
      };
      fullName = mkOption {
        description = "User full name";
        type = types.nullOr types.str;
        default = null;
      };
      email = mkOption {
        description = "User email address";
        type = types.nullOr types.str;
        default = null;
      };
      gpgKeyId = mkOption {
        description = "GPG Key ID";
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
}