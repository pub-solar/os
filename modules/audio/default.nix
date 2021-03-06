{ lib, config, pkgs, ... }:
with lib;
let
  psCfg = config.pub-solar;
  cfg = config.pub-solar.audio;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
in
{
  options.pub-solar.audio = {
    enable = mkEnableOption "Life in highs and lows";
    mopidy.enable = mkEnableOption "Life with mopidy";
    bluetooth.enable = mkEnableOption "Life with bluetooth";
  };

  config = mkIf cfg.enable {
    home-manager = with pkgs; pkgs.lib.setAttrByPath [ "users" psCfg.user.name ] {
      home.packages = [
        # easyeffects, e.g. for microphone noise filtering
        easyeffects
        mu
        pavucontrol
        pa_applet
        playerctl
        # Needed for pactl cmd, until pw-cli is more mature (vol up/down hotkeys?)
        pulseaudio
        vimpc
      ];
      xdg.configFile."vimpc/vimpcrc".source = ./.config/vimpc/vimpcrc;
      systemd.user.services.easyeffects = import ./easyeffects.service.nix pkgs;
    };

    # Enable sound using pipewire-pulse
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      config.pipewire = {
        context.default.clock = {
          allowed-rates = [ 44100 48000 88200 96000 ];
          rate = 44100;
        };
      };
      config.pipewire-pulse = builtins.fromJSON (builtins.readFile ./pipewire-pulse.conf.json);

      # Bluetooth configuration for pipewire
      media-session.config.bluez-monitor.rules = mkIf cfg.bluetooth.enable [
        {
          # Matches all cards
          matches = [{ "device.name" = "~bluez_card.*"; }];
          actions = {
            "update-props" = {
              "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
              # mSBC is not expected to work on all headset + adapter combinations.
              "bluez5.msbc-support" = true;
            };
          };
        }
        {
          matches = [
            # Matches all sources
            { "node.name" = "~bluez_input.*"; }
            # Matches all outputs
            { "node.name" = "~bluez_output.*"; }
          ];
          actions = {
            "node.pause-on-idle" = false;
          };
        }
      ];
    };

    # Enable bluetooth
    hardware.bluetooth.enable = mkIf cfg.bluetooth.enable true;
    services.blueman.enable = mkIf cfg.bluetooth.enable true;

    # Enable audio server & client
    services.mopidy = mkIf cfg.mopidy.enable ((import ./mopidy.nix) pkgs);
  };
}
