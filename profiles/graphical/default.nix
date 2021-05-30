{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  pub-solar.graphical.enable = true;
  pub-solar.sway.enable = true;
  pub-solar.social.enable = true;
}
