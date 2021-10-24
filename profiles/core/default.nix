{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  imports = [ ../cachix ];

  config = {
    pub-solar.terminal-life.enable = true;
    pub-solar.audio.enable = true;
    pub-solar.crypto.enable = true;
    pub-solar.devops.enable = true;

    nix.systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

    environment = {

      systemPackages = with pkgs; [
        # Core unix utility packages
        coreutils-full
        progress
        dnsutils
        inetutils
        pciutils
        usbutils
        git
        git-lfs
        git-bug
        wget
        openssl
        openssh
        curl
        htop
        lsof
        psmisc
        xdg-utils
        sysfsutils
        renameutils
        nfs-utils
        moreutils
        mailutils
        keyutils
        input-utils
        elfutils
        binutils
        dateutils
        diffutils
        findutils
        exfat-utils
        file

        # zippit
        zip
        unzip

        # Modern modern utilities
        p7zip
        croc
        jq

        # Nix specific utilities
        niv
        manix
        nix-index
        # Build broken, python2.7-PyJWT-2.0.1.drv' failed
        #nixops
        psos

        # Fun
        neofetch
      ];
    };

    fonts = {
      fonts = with pkgs; [ powerline-fonts dejavu_fonts ];

      fontconfig.defaultFonts = {

        monospace = [ "DejaVu Sans Mono for Powerline" ];

        sansSerif = [ "DejaVu Sans" ];

      };
    };

    nix = {
      package = pkgs.nix-dram;

      autoOptimiseStore = true;

      gc.automatic = true;

      optimise.automatic = true;

      useSandbox = true;

      allowedUsers = [ "@wheel" ];

      trustedUsers = [ "root" "@wheel" ];

      extraOptions = ''
        min-free = 536870912
        keep-outputs = true
        keep-derivations = true
        fallback = true
        # used by nix-dram
        default-flake = flake:nixpkgs
      '';
    };

    system.autoUpgrade.enable = true;

    # For rage encryption, all hosts need a ssh key pair
    services.openssh = {
      enable = true;
      openFirewall = lib.mkDefault false;
    };

    services.earlyoom.enable = true;

    boot.supportedFilesystems = [ "ntfs" ];
  };
}
