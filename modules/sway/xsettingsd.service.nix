pkgs:
{
  Unit = {
    Description = "X Settings Daemon";
    Documentation = [ "https://github.com/derat/xsettingsd/wiki/Installation" ];
    BindsTo = [ "sway-session.target" ];
    After = [ "sway-session.target" ];
    # ConditionEnvironment requires systemd v247 to work correctly
    ConditionEnvironment = [ "WAYLAND_DISPLAY" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.xsettingsd}/bin/xsettingsd";
    ExecStop = "/run/current-system/sw/bin/env pkill xsettingsd";
  };
  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
