{ config, pkgs, lib, ... }:
let
  psCfg = config.pub-solar;
in
{
  imports = [
    ./home.nix
  ];

  users = {
    mutableUsers = false;

    users = with pkgs; pkgs.lib.setAttrByPath [ psCfg.user.name ] {
      # Indicates whether this is an account for a “real” user.
      # This automatically sets group to users, createHome to true,
      # home to /home/username, useDefaultShell to true, and isSystemUser to false.
      isNormalUser = true;
      description = psCfg.user.description;
      extraGroups = [ "wheel" "docker" "input" "audio" "networkmanager" "lp" "scanner" ];
      initialHashedPassword = if psCfg.user.password != null then psCfg.user.password else "";
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = if psCfg.user.publicKeys != null then psCfg.user.publicKeys else [ ];
    };
  };
}
