{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.virtualisation;
  doesGaming = config.pub-solar.gaming.enable;
  extraObsPlugins = if doesGaming then [ pkgs.obs-studio-plugins.looking-glass-obs ] else [ ];
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
      edk2
      OVMF
      win-virtio
      looking-glass-client
      lgcl
    ];

    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      xdg.dataFile."libvirt/.keep".text = "# this file is here to generate the directory";
      home.packages = extraObsPlugins;
    };

    systemd.tmpfiles.rules = [
      "f  /dev/shm/looking-glass  0660  ${psCfg.user.name}  kvm"
    ];
    networking.bridges.virbr1.interfaces = [ ];
    networking.interfaces.virbr1 = {
      ipv4.addresses = [
        { address = "192.168.123.1"; prefixLength = 24; }
      ];
    };
  };
}
