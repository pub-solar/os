{ config, pkgs, lib, ... }:

let
  cfg = config.pub-solar.x-os;
in
with lib; {
  options = {
    pub-solar.x-os.keyfile = mkOption {
      type = types.str;
      description = "Keyfile location";
    };

    pub-solar.x-os.enableBootLoader = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to include the grub bootloader. Turn this off for ISO images.";
    };
  };

  config = {
    # Enable plymouth for better experience of booting
    boot.plymouth.enable = true;

    # Use Keyfile to unlock the root partition to avoid keying in twice.
    # Allow fstrim to work on it.
    boot.initrd = mkIf cfg.enableBootLoader {
      secrets = { "/keyfile.bin" = cfg.keyfile; };
      luks.devices."cryptroot" = {
        keyFile = "/keyfile.bin";
        allowDiscards = true;
        fallbackToPassword = true;
      };
    };

    # Use GRUB with encrypted /boot under EFI env.
    boot.loader = {
      efi.efiSysMountPoint = "/boot/efi";

      grub = {
        enable = cfg.enableBootLoader;
        version = 2;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
      };
    };
  };
}
