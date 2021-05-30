pkgs:
{
  Service = {
    Type = "dbus";
    BusName = "com.github.wwmm.pulseeffects";
    ExecStart = "${pkgs.pulseeffects-pw}/bin/pulseeffects --gapplication-service";
  };
}
