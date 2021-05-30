pkgs:
{
  Unit = {
    Description = "ydotool - Generic command-line automation tool (no X!)";
    Documentation = [ "https://github.com/ReimuNotMoe/ydotool" ];
    BindsTo = [ "sway-session.target" ];
    After = [ "sway-session.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.ydotool}/bin/ydotoold";
    Restart = "on-failure";
    RestartSec = "1";
    TimeoutStopSec = "10";
  };
  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
