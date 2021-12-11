{ config, pkgs, lib, vm, ... }:
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
  varsFile = "${xdg.dataHome}/libvirt/OVMF_VARS_${vm.name}.fd";
  generateXML = import ./guest-xml.nix;
in
{
  serviceConfig = {
    Type = "oneshot";
    RemainAfterExit = "yes";
    Restart = "no";
  };

  script =
    let
      networkXML = pkgs.writeText "network.xml" (import ./network-xml.nix { inherit config; inherit pkgs; inherit lib; });
      machineXML = pkgs.writeText "${vm.name}.xml" (generateXML { inherit config; inherit pkgs; inherit lib; inherit vm; varsFile = varsFile; });
    in
    ''
      echo "Checking if ${vm.name} is already running"
      STATUS=$(${pkgs.libvirt}/bin/virsh list --all | grep "${vm.name}" | ${pkgs.gawk}/bin/awk '{ print $3 " " $4 }' )
      if [[ $STATUS != "shut off" && $STATUS != "" ]]; then
        echo "Domain ${vm.name} is already running or in an inconsistent state:"
        ${pkgs.libvirt}/bin/virsh list --all
        exit 0
      fi

      NET_TMP_FILE="/tmp/network.xml"

      NETUUID="$(${pkgs.libvirt}/bin/virsh net-uuid 'default' || true)"
      (sed "s/UUID/$NETUUID/" '${networkXML}') > "$NET_TMP_FILE"

      ${pkgs.libvirt}/bin/virsh net-define "$NET_TMP_FILE"
      ${pkgs.libvirt}/bin/virsh net-start 'default' || true

      VARS_FILE=${varsFile}
      if [ ! -f "$VARS_FILE" ]; then
        cp /run/libvirt/nix-ovmf/OVMF_VARS.fd "$VARS_FILE"
      fi

      # Load the template contents into a tmp file
      TMP_FILE="/tmp/${vm.name}.xml"
      cat "${machineXML}" > "$TMP_FILE"

      # Set VM UUID
      UUID="$(${pkgs.libvirt}/bin/virsh domuuid '${vm.name}' || true)"
      sed -i "s/UUID/''${UUID}/" "$TMP_FILE"

      ${if vm.handOverUSBDevices then ''
        # Hand over keyboard
        USB_DEV=$(${pkgs.usbutils}/bin/lsusb | grep 046d:c52b | grep 'Bus 001' | cut -b 18)
        LINE_NUMBER=$(cat $TMP_FILE | grep -n -A 1 0xc52b | tail -n 1 | cut -b 1,2,3)
        sed -i "''${LINE_NUMBER}s/\(.\{33\}\)./\1''${USB_DEV}/" "$TMP_FILE"

        # Hand over mouse
        USB_BUS=$(${pkgs.usbutils}/bin/lsusb | grep 046d:c328 | cut -b 7)
        USB_DEV=$(${pkgs.usbutils}/bin/lsusb | grep 046d:c328 | cut -b 18)
        LINE_NUMBER=$(cat $TMP_FILE | grep -n -A 1 0xc328 | tail -n 1 | cut -b 1,2,3)
        sed -i "''${LINE_NUMBER}s/.*/<address bus=\"''${USB_BUS}\" device=\"''${USB_DEV}\" \/>/" "$TMP_FILE"
      '' else ""}

      # TODO: Set correct pci address for the GPU too

      # Setup looking glass shm file
      ${pkgs.coreutils-full}/bin/truncate -s 0 /dev/shm/looking-glass
      ${pkgs.coreutils-full}/bin/dd if=/dev/zero of=/dev/shm/looking-glass bs=1M count=32

      # Load and start the xml definition
      ${pkgs.libvirt}/bin/virsh define "$TMP_FILE"
      ${pkgs.libvirt}/bin/virsh start '${vm.name}'
    '';

  preStop =
    ''
      ${pkgs.libvirt}/bin/virsh shutdown '${vm.name}'
      let "timeout = $(date +%s) + 10"
      while [ "$(${pkgs.libvirt}/bin/virsh list --name | grep --count '^${vm.name}$')" -gt 0 ]; do
        if [ "$(date +%s)" -ge "$timeout" ]; then
          # Meh, we warned it...
          ${pkgs.libvirt}/bin/virsh destroy '${vm.name}'
        else
          # The machine is still running, let's give it some time to shut down
          sleep 0.5
        fi
      done

      ${pkgs.libvirt}/bin/virsh net-destroy 'default' || true
    '';
}
