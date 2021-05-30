{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.office;
in
{
  options.pub-solar.office = {
    enable = mkEnableOption "Install office programs, also enables printing server";
  };

  config = mkIf cfg.enable {
    pub-solar.printing.enable = true;

    # Gnome PDF viewer
    programs.evince.enable = true;
    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      home.packages = [
        libreoffice-fresh
        gnome3.simple-scan
        # Tools like pdfunite
        poppler_utils
      ];
    };
  };
}
