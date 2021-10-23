{ config, pkgs, lib, self, ... }:

let
  cfg = config.pub-solar.x-os;
in
with lib; {
  options = {
    pub-solar.x-os.keyfile = mkOption {
      type = types.str;
      description = "Keyfile location";
    };
  };

  config = {
    # Enable plymouth for better experience of booting
    boot.plymouth.enable = true;

    # Use Keyfile to unlock the root partition to avoid keying in twice.
    # Allow fstrim to work on it.
    age.secrets.luksKeyFile.file = "${self}/secrets/${cfg.keyfile}";
    boot.initrd = {
      secrets = { "/keyfile.bin" = "/run/secrets/${cfg.keyfile}"; };
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
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
      };
    };
  };
}
