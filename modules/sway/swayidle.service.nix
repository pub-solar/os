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
    Environment = "PATH=/run/current-system/sw/bin:${pkgs.sway}/bin:${pkgs.swaylock}/bin:${pkgs.swaylock-bg}/bin";
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
