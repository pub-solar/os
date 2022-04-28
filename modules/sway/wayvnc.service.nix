pkgs:
{
  Unit = {
    Description = "A VNC server for wlroots based Wayland compositors ";
    Documentation = "https://github.com/any1/wayvnc";
    BindsTo = [ "sway-session.target" ];
    After = [ "graphical-session-pre.target" "network-online.target" ];
    Wants = [ "graphical-session-pre.target" "network-online.target" ];
  };

  Service = {
    Type = "simple";
    ExecStart = "${pkgs.wayvnc}/bin/wayvnc";
  };

  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
