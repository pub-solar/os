{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  pub-solar.virtualisation.enable = true;
}
