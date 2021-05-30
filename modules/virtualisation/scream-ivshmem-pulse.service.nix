pkgs:
{
  enable = true;
  wantedBy = [ "multi-user.target" ];
  unitConfig = {
    Description = "Scream IVSHMEM pulse reciever";
    BindsTo = [ "pipewire-pulse.service" ];
    After = [ "pipewire-pulse.service" ];
    Wants = [ "pipewire-pulse.service" ];
  };
  serviceConfig = {
    Type = "simple";
    ExecStartPre = [
      "${pkgs.coreutils-full}/bin/truncate -s 0 /dev/shm/scream-ivshmem"
      "${pkgs.coreutils-full}/bin/dd if=/dev/zero of=/dev/shm/scream-ivshmem bs=1M count=2"
    ];
    ExecStart = "${pkgs.scream}/bin/scream -m /dev/shm/scream-ivshmem";
  };
}
