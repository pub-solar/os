{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.pub-solar.x-os;
in
{
  config = {
    # Enable plymouth for better experience of booting
    boot.plymouth.enable = true;

    # Mount / luks device in initrd
    # Allow fstrim to work on it.
    # The ! makes this enabled by default
    boot.initrd = mkIf (!cfg.iso-options.enable) {
      luks.devices."cryptroot" = {
        allowDiscards = true;
      };
    };

    boot.loader.systemd-boot.enable = true;
  };
}
