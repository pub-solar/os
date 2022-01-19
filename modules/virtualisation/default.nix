{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.virtualisation;
in
{
  options.pub-solar.virtualisation = {
    enable = mkEnableOption "Life in libvirt";
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
    ];

    virtualisation.libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
    };
    users.users = pkgs.lib.setAttrByPath [ psCfg.user.name ] {
      extraGroups = [ "libvirtd" ];
    };

    environment.systemPackages = with pkgs; [
      coreutils-full
      usbutils
      libvirt
      libvirt-glib
      qemu
      virt-manager
      python38Packages.libvirt
      gvfs
      scream
      edk2
      OVMF
      win-virtio
    ];

    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      xdg.dataFile."libvirt/.keep".text = "# this file is here to generate the directory";
    };

    systemd.tmpfiles.rules = [ "f  /dev/shm/scream-ivshmem  0660  ${psCfg.user.name}  kvm" ];
    systemd.user.services.scream-ivshmem-pulse = import ./scream-ivshmem-pulse.service.nix pkgs;
  };
}
