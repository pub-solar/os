{ config, pkgs, lib, ... }:
with lib;
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
  createService = import ./create-service.nix;

  isolateGPU = "rx550x";
  handOverUSBDevices = false;

  isolateAnyGPU = isolateGPU != null;
in
{
  config = mkIf psCfg.virtualisation.enable {
    boot.extraModprobeConfig = mkIf isolateAnyGPU (concatStringsSep "\n" [
      "softdep amdgpu pre: vfio vfio_pci"
      (if isolateGPU == "rx5700xt"
      then "options vfio-pci ids=1002:731f,1002:ab38"
      else "options vfio-pci ids=1002:699f,1002:aae0"
      )
    ]);

    systemd.user.services = {
      vm-windows = createService {
        inherit config;
        inherit pkgs;
        inherit lib;
        vm = {
          name = "windows";
          disk = "/dev/disk/by-id/ata-SanDisk_SDSSDA240G_162402455603";
          id = "http://microsoft.com/win/10";
          gpu = true;
          mountHome = false;
          isolateGPU = isolateGPU;
          handOverUSBDevices = handOverUSBDevices;
        };
      };
      vm-manjaro = createService {
        inherit config;
        inherit pkgs;
        inherit lib;
        vm = {
          name = "manjaro";
          disk = "/dev/disk/by-id/ata-KINGSTON_SM2280S3G2240G_50026B726B0265CE";
          id = "https://manjaro.org/download/#i3";
          gpu = true;
          mountHome = true;
          isolateGPU = isolateGPU;
          handOverUSBDevices = handOverUSBDevices;
        };
      };
    };
  };
}
