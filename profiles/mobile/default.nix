{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  pub-solar.mobile.enable = true;
}
