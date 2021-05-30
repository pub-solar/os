pkgs:
{
  Unit = {
    Description = "set color temperature of display according to time of day";
    Documentation = [ "man:gammastep(1)" ];
    BindsTo = [ "sway-session.target" ];
    After = [ "sway-session.target" ];
    # ConditionEnvironment requires systemd v247 to work correctly
    ConditionEnvironment = [ "WAYLAND_DISPLAY" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.gammastep}/bin/gammastep -l geoclue2 -m wayland -v";
  };
  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
