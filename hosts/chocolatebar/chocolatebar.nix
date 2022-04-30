{ config, pkgs, lib, self, ... }:
with lib;
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
in
{
  imports = [
    ./configuration.nix
    ./virtualisation
  ];

  config = {
    hardware.cpu.amd.updateMicrocode = true;

    hardware.opengl.extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];

    services.openssh.openFirewall = true;
    networking.firewall.allowedTCPPorts = mkIf psCfg.sway.vnc.enable [ 5901 ];

    environment.systemPackages = with pkgs; [
      wayvnc
    ];

    age.secrets."vnc-key.pem" = {
      file = "${self}/secrets/vnc-key-chocolatebar.pem";
      mode = "700";
      owner = psCfg.user.name;
    };
    age.secrets."vnc-cert.pem" = {
      file = "${self}/secrets/vnc-cert-chocolatebar.pem";
      mode = "700";
      owner = psCfg.user.name;
    };
    pub-solar.sway.vnc.enable = true;

    home-manager.users."${psCfg.user.name}".xdg.configFile = mkIf psCfg.sway.enable {
      "sway/config.d/10-autostart.conf".source = ./.config/sway/config.d/autostart.conf;
      "sway/config.d/10-input-defaults.conf".source = ./.config/sway/config.d/input-defaults.conf;
      "sway/config.d/10-screens.conf".source = ./.config/sway/config.d/screens.conf;
    };
  };
}
