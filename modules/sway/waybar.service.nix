pkgs:
{
  Unit = {
    Description = "Highly customizable Wayland bar for Sway and Wlroots based compositors.";
    Documentation = "https://github.com/Alexays/Waybar/wiki/";
    BindsTo = [ "sway-session.target" ];
    After = [ "graphical-session-pre.target" "network-online.target" ];
    Wants = [ "graphical-session-pre.target" "network-online.target" "blueman-applet.service" ];
  };

  Service = {
    Type = "dbus";
    Environment = "PATH=${pkgs.bash}/bin:${pkgs.pavucontrol}/bin";
    BusName = "fr.arouillard.waybar";
    ExecStart = "${pkgs.waybar}/bin/waybar";
  };

  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
