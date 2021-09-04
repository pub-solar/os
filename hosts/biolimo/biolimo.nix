{ config, pkgs, lib, ... }:
with lib;
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
in
{
  imports = [
    ./configuration.nix
  ];

  config = {
    pub-solar.x-os.keyfile = "/etc/nixos/hosts/biolimo/secrets/keyfile.bin";

    hardware.cpu.intel.updateMicrocode = true;

    networking.firewall.allowedTCPPorts = [ 5000 ];

    home-manager.users."${psCfg.user.name}".xdg.configFile = mkIf psCfg.sway.enable {
      "sway/config.d/10-screens.conf".source = ./.config/sway/config.d/screens.conf;
      "sway/config.d/10-autostart.conf".source = ./.config/sway/config.d/autostart.conf;
      "sway/config.d/10-input-defaults.conf".source = ./.config/sway/config.d/input-defaults.conf;
      "sway/config.d/10-custom-keybindings.conf".source = ./.config/sway/config.d/custom-keybindings.conf;
    };
  };
}
