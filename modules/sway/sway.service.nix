pkgs:
{
  Unit = {
    Description = "sway - SirCmpwn's Wayland window manager";
    Documentation = [ "man:sway(5)" ];
    BindsTo = [ "graphical-session.target" ];
    Wants = [ "graphical-session-pre.target" ];
    After = [ "graphical-session-pre.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.sway}/bin/sway";
    Restart = "on-failure";
    RestartSec = "1";
    TimeoutStopSec = "10";
    ExecStopPost = "${pkgs.systemd}/bin/systemctl --user unset-environment SWAYSOCK DISPLAY I3SOCK WAYLAND_DISPLAY";
  };
}
