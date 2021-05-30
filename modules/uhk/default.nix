{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.uhk;
in
{
  options.pub-solar.uhk = {
    enable = mkEnableOption "Ultimate Hacking Keyboard";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      uhk-agent
    ];

    # Ultimate Hacking Keyboard rules
    # These are the udev rules for accessing the USB interfaces of the UHK as non-root users.
    services.udev.packages = with pkgs; [
      uhk-agent
    ];
    services.udev.extraRules = ''
      SUBSYSTEM=="input", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", GROUP="input", MODE="0660"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", TAG+="uaccess"
      KERNEL=="hidraw*", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", TAG+="uaccess"
    '';
  };
}
