pkgs:
{
  Unit = {
    Description = "Actions gestures on your touchpad using libinput";
    Documentation = [ "https://github.com/bulletmark/libinput-gestures" ];
    BindsTo = [ "sway-session.target" ];
    After = [ "sway-session.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
    Restart = "on-failure";
    RestartSec = "1";
    TimeoutStopSec = "10";
  };
  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
