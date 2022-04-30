{ self, config, lib, pkgs, ... }:
let inherit (lib) fileContents;
in
{
  imports = [ ../cachix ];

  config = {
    pub-solar.audio.mopidy.enable = true;
    pub-solar.audio.bluetooth.enable = true;
    pub-solar.docker.enable = true;
    pub-solar.nextcloud.enable = true;
    pub-solar.office.enable = true;
    # pub-solar.printing.enable = true; # this is enabled automatically if office is enabled
  };
}
