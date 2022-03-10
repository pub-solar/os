{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.paperless;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
in
{
  options.pub-solar.paperless = {
    enable = mkEnableOption "All you need to go paperless";
    ocrLanguage = mkOption {
      description = "OCR language";
      type = types.str;
      example = "eng+deu";
      default = "eng";
    };
    consumptionDir = mkOption {
      description = "Directory to be watched";
      type = types.str;
      example = "/var/lib/paperless/consume";
      default = "/home/${psCfg.user.name}/Documents";
    };
  };

  config = mkIf cfg.enable {
    services.paperless-ng = {
      enable = true;
      consumptionDir = cfg.consumptionDir;
      extraConfig = {
        PAPERLESS_OCR_LANGUAGE = cfg.ocrLanguage;
      };
    };
    environment.systemPackages = [
      pkgs.hplip
    ];
  };
}
