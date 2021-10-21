{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  imports = [ ../cachix ];
  config = {
    pub-solar.printing.enable = true;
    pub-solar.x-os.enableBootLoader = true;
  };
}
