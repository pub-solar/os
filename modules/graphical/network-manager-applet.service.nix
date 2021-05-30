pkgs:
{
  Unit = {
    Description = "Lightweight Wayland notification daemon";
    BindsTo = [ "sway-session.target" ];
    After = [ "sway-session.target" ];
    # ConditionEnvironment requires systemd v247 to work correctly
    ConditionEnvironment = [ "WAYLAND_DISPLAY" ];
  };
  Service = {
    ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator";
  };
  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
