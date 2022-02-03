{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  imports = [ ../cachix ];
  config = {
    pub-solar.graphical.wayland.software-renderer.enable = true;
    pub-solar.sway.terminal = "foot";
    pub-solar.x-os.iso-options.enable = true;
  };
}
