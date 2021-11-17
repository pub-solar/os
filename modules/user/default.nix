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
      description = mkOption {
        description = "User description";
        type = types.nullOr types.str;
        default = "The main PubSolarOS user";
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
