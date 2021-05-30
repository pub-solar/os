{ config, pkgs, lib, ... }: with lib; {
  # Both things below are for
  # https://github.com/NixOS/nixpkgs/issues/124215
  documentation.info.enable = lib.mkForce false;
  nix.sandboxPaths = [ "/bin/sh=${pkgs.bash}/bin/sh" ];
}
