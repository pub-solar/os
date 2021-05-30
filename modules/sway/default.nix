{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.sway;
in
{
  options.pub-solar.sway = {
    enable = mkEnableOption "Life in boxes";
  };
  options.pub-solar.sway.v4l2loopback.enable = mkOption {
    type = types.bool;
    default = true;
    description = "WebCam streaming tool";
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf (cfg.v4l2loopback.enable) {
      boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
      boot.kernelModules = [ "v4l2loopback" ];
      boot.extraModprobeConfig = ''
        options v4l2loopback exclusive_caps=1 devices=3
      '';
    })

    ({
      environment.systemPackages = with pkgs; [
        linuxPackages.v4l2loopback
      ];

      programs.sway.enable = true;

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
        gtkUsePortal = true;
      };

      services.pipewire.enable = true;

      home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
        home.packages = with pkgs; [
          sway
          grim
          kanshi
          mako
          slurp
          swayidle
          swaylock
          swaybg
          xwayland

          libappindicator-gtk3

          wl-clipboard
          wf-recorder
          brightnessctl
          gammastep
          geoclue2
          xsettingsd
          ydotool

          swaylock-bg
          sway-launcher
          sway-service
          import-gtk-settings
          s
          wcwd
        ];

        programs.waybar.enable = true;
        #programs.waybar.systemd.enable = true;

        systemd.user.services.mako = import ./mako.service.nix pkgs;
        systemd.user.services.sway = import ./sway.service.nix pkgs;
        systemd.user.services.swayidle = import ./swayidle.service.nix pkgs;
        systemd.user.services.xsettingsd = import ./xsettingsd.service.nix pkgs;
        systemd.user.services.waybar = import ./waybar.service.nix pkgs;
        systemd.user.targets.sway-session = import ./sway-session.target.nix pkgs;

        xdg.configFile."sway/config".source = ./config/config;
        xdg.configFile."sway/config.d/colorscheme.conf".source = ./config/config.d/colorscheme.conf;
        xdg.configFile."sway/config.d/theme.conf".source = ./config/config.d/theme.conf;
        xdg.configFile."sway/config.d/gaps.conf".source = ./config/config.d/gaps.conf;
        xdg.configFile."sway/config.d/custom-keybindings.conf".source = ./config/config.d/custom-keybindings.conf;
        xdg.configFile."sway/config.d/applications.conf".source = ./config/config.d/applications.conf;
        xdg.configFile."sway/config.d/systemd.conf".source = ./config/config.d/systemd.conf;
      };
    })
  ]);
}
