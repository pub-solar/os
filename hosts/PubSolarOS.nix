{ suites, ... }:
{
  ### root password is empty by default ###
  ### default password: pub-solar, optional: add your SSH keys
  imports =
    suites.iso
  ;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  fileSystems."/" = { device = "/dev/disk/by-label/nixos"; };
}
