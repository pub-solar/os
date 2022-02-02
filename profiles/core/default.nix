{ self, config, lib, pkgs, inputs, ... }:
let inherit (lib) fileContents;
in
{
  # Sets nrdxp.cachix.org binary cache which just speeds up some builds
  imports = [ ../cachix ];

  config = {
    pub-solar.terminal-life.enable = true;
    pub-solar.audio.enable = true;
    pub-solar.crypto.enable = true;
    pub-solar.devops.enable = true;

    # This is just a representation of the nix default
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
        gitFull
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
        nix-tree
        # Build broken, python2.7-PyJWT-2.0.1.drv' failed
        #nixops
        psos
        nvd

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
      # use nix-dram, a patched nix command, see: https://github.com/dramforever/nix-dram
      package = inputs.nix-dram.packages.${pkgs.system}.nix-dram;

      # Improve nix store disk usage
      autoOptimiseStore = true;
      gc.automatic = true;
      optimise.automatic = true;

      # Prevents impurities in builds
      useSandbox = true;

      # give root and @wheel special privileges with nix
      trustedUsers = [ "root" "@wheel" ];

      # Generally useful nix option defaults
      extraOptions = ''
        min-free = 536870912
        keep-outputs = true
        keep-derivations = true
        fallback = true
        # used by nix-dram
        default-flake = flake:nixpkgs
      '';
    };

    # For rage encryption, all hosts need a ssh key pair
    services.openssh = {
      enable = true;
      openFirewall = lib.mkDefault false;
    };

    # Service that makes Out of Memory Killer more effective
    services.earlyoom.enable = true;

    boot.supportedFilesystems = [ "ntfs" ];
  };
}
