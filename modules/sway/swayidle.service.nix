pkgs:
{
  Unit = {
    Description = "Idle manager for Wayland";
    Documentation = [ "man:swayidle(1)" ];
    BindsTo = [ "graphical-session.target" ];
    Wants = [ "graphical-session-pre.target" ];
    After = [ "graphical-session-pre.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = ''${pkgs.swayidle}/bin/swayidle -w \
      timeout 600 'swaylock-bg' \
      timeout 900 'swaymsg "output * dpms off"' \
      resume 'swaymsg "output * dpms on"' \
      before-sleep 'swaylock-bg'
    '';
  };
  Install = {
    WantedBy = [ "sway-session.target" ];
  };
}
