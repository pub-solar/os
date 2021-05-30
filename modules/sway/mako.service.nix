pkgs:
{
  Unit = {
    Description = "Lightweight Wayland notification daemon";
    Documentation = [ "man:mako(1)" ];
    BindsTo = [ "sway-session.target" ];
    After = [ "sway-session.target" ];
    # ConditionEnvironment requires systemd v247 to work correctly
    ConditionEnvironment = [ "WAYLAND_DISPLAY" ];
  };
  Service = {
    Type = "dbus";
    BusName = "org.freedesktop.Notifications";
    ExecStart = "${pkgs.mako}/bin/mako";
    ExecReload = "${pkgs.mako}/bin/makoctl reload";
  };
  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
