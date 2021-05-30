pkgs:
{
  Unit = {
    Description = "Nextcloud Client";
    BindsTo = [ "sway-session.target" ];
    Wants = [ "graphical-session-pre.target" ];
    After = [ "graphical-session-pre.target" ];
    # ConditionEnvironment requires systemd v247 to work correctly
    ConditionEnvironment = [ "WAYLAND_DISPLAY" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud --background";
    ExecReload = "/run/current-system/sw/bin/kill -HUP $MAINPID";
    KillMode = "process";
    Restart = "on-failure";
  };
  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
