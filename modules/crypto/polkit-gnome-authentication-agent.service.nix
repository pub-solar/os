pkgs:
{
  Unit = {
    Description = "Legacy polkit authentication agent for GNOME";
    Documentation = [ "https://gitlab.freedesktop.org/polkit/polkit/" ];
    BindsTo = [ "sway-session.target" ];
    After = [ "sway-session.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  };
  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
