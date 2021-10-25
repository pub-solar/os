{ profiles, ... }:
{
  ### root password is empty by default ###
  imports = [
    # profiles.networking
    profiles.core
    profiles.users.root # make sure to configure ssh keys
    profiles.users.pub-solar
    profiles.base-user
    profiles.graphical
    profiles.pub-solar-iso
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
}
