{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  imports = [ ../cachix ];
  config = {
    pub-solar.x-os.iso-options.enable = true;
  };
}
