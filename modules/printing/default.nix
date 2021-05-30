{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.printing;
in
{
  options.pub-solar.printing = {
    enable = mkEnableOption "CUPSSSss";
  };

  config = mkIf cfg.enable {
    services.avahi.enable = true;
    services.avahi.nssmdns = true;
    services.avahi.publish.enable = true;
    services.avahi.publish.userServices = true;
    services.printing.enable = true;
    services.printing.browsing = true;
    services.printing.listenAddresses = [ "localhost:631" ];
    services.printing.allowFrom = [ "all" ];
    services.printing.defaultShared = false;
    services.printing.drivers = [
      pkgs.gutenprint
      pkgs.brgenml1lpr
      pkgs.brgenml1cupswrapper
      pkgs.brlaser
      pkgs.cups-brother-hl3140cw
    ];
    hardware.sane = {
      enable = true;
      brscan4.enable = true;
    };
  };
}
