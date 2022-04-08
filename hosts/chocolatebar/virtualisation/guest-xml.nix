{ config, pkgs, lib, vm, varsFile, ... }:
let
  psCfg = config.pub-solar;
  xdg = config.home-manager.users."${psCfg.user.name}".xdg;
  home = config.home-manager.users."${psCfg.user.name}".home;
in
''
  <domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
    <name>${vm.name}</name>
    <uuid>UUID</uuid>
    <metadata>
      <libosinfo:libosinfo xmlns:libosinfo="http://libosinfo.org/xmlns/libvirt/domain/1.0">
        <libosinfo:os id="${vm.id}"/>
      </libosinfo:libosinfo>
    </metadata>
    <memory unit='KiB'>33554432</memory>
    <currentMemory unit='KiB'>33554432</currentMemory>
    <vcpu placement='static'>12</vcpu>
    <cputune>
      <vcpupin vcpu='0' cpuset='6'/>
      <vcpupin vcpu='1' cpuset='7'/>
      <vcpupin vcpu='2' cpuset='8'/>
      <vcpupin vcpu='3' cpuset='9'/>
      <vcpupin vcpu='4' cpuset='10'/>
      <vcpupin vcpu='5' cpuset='11'/>
      <vcpupin vcpu='6' cpuset='18'/>
      <vcpupin vcpu='7' cpuset='19'/>
      <vcpupin vcpu='8' cpuset='20'/>
      <vcpupin vcpu='9' cpuset='21'/>
      <vcpupin vcpu='10' cpuset='22'/>
      <vcpupin vcpu='11' cpuset='23'/>
    </cputune>
    <resource>
      <partition>/machine</partition>
    </resource>
    <os>
      <type arch='x86_64' machine='pc-q35-4.2'>hvm</type>
      <loader readonly='yes' type='pflash'>/run/libvirt/nix-ovmf/OVMF_CODE.fd</loader>
      <nvram>${varsFile}</nvram>
      <boot dev='hd'/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <hyperv>
        <relaxed state='on'/>
        <vapic state='on'/>
        <spinlocks state='on' retries='8191'/>
        <vendor_id state='on' value='wahtever'/>
      </hyperv>
      <kvm>
        <hidden state='on'/>
      </kvm>
      <vmport state='off'/>
    </features>
    <cpu mode='custom' match='exact' check='full'>
      <model fallback='forbid'>EPYC-IBPB</model>
      <vendor>AMD</vendor>
      <topology sockets='1' dies='1' cores='6' threads='2'/>
      <feature policy='require' name='x2apic'/>
      <feature policy='require' name='tsc-deadline'/>
      <feature policy='require' name='hypervisor'/>
      <feature policy='require' name='tsc_adjust'/>
      <feature policy='require' name='clwb'/>
      <feature policy='require' name='umip'/>
      <feature policy='require' name='stibp'/>
      <feature policy='require' name='arch-capabilities'/>
      <feature policy='require' name='ssbd'/>
      <feature policy='require' name='xsaves'/>
      <feature policy='require' name='cmp_legacy'/>
      <feature policy='require' name='perfctr_core'/>
      <feature policy='require' name='clzero'/>
      <feature policy='require' name='wbnoinvd'/>
      <feature policy='require' name='amd-ssbd'/>
      <feature policy='require' name='virt-ssbd'/>
      <feature policy='require' name='rdctl-no'/>
      <feature policy='require' name='skip-l1dfl-vmentry'/>
      <feature policy='require' name='mds-no'/>
      <feature policy='require' name='pschange-mc-no'/>
      <feature policy='disable' name='monitor'/>
      <feature policy='disable' name='svm'/>
      <feature policy='require' name='topoext'/>
    </cpu>
    <clock offset='utc'>
      <timer name='rtc' tickpolicy='catchup'/>
      <timer name='pit' tickpolicy='delay'/>
      <timer name='hpet' present='no'/>
    </clock>
    <on_poweroff>destroy</on_poweroff>
    <on_reboot>restart</on_reboot>
    <on_crash>destroy</on_crash>
    <pm>
      <suspend-to-mem enabled='no'/>
      <suspend-to-disk enabled='no'/>
    </pm>
    <devices>
      <emulator>${pkgs.qemu}/bin/qemu-system-x86_64</emulator>
      <disk type='block' device='disk'>
        <driver name='qemu' type='raw' cache='none' discard='unmap' />
        <source dev='${vm.disk}'/>
        <backingStore/>
        <target dev='vdb' bus='virtio'/>
        <address type='pci' domain='0x0000' bus='0x04' slot='0x00' function='0x0'/>
      </disk>
      <controller type='usb' index='0' model='qemu-xhci' ports='15'>
        <address type='pci' domain='0x0000' bus='0x02' slot='0x00' function='0x0'/>
      </controller>
      <controller type='sata' index='0'>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x1f' function='0x2'/>
      </controller>
      <controller type='pci' index='0' model='pcie-root'/>
      <controller type='pci' index='1' model='pcie-root-port'>
        <model name='pcie-root-port'/>
        <target chassis='1' port='0x10'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0' multifunction='on'/>
      </controller>
      <controller type='pci' index='2' model='pcie-root-port'>
        <model name='pcie-root-port'/>
        <target chassis='2' port='0x11'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x1'/>
      </controller>
      <controller type='pci' index='3' model='pcie-root-port'>
        <model name='pcie-root-port'/>
        <target chassis='3' port='0x12'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x2'/>
      </controller>
      <controller type='pci' index='4' model='pcie-root-port'>
        <model name='pcie-root-port'/>
        <target chassis='4' port='0x13'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x3'/>
      </controller>
      <controller type='pci' index='5' model='pcie-root-port'>
        <model name='pcie-root-port'/>
        <target chassis='5' port='0x14'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x4'/>
      </controller>
      <controller type='pci' index='6' model='pcie-root-port'>
        <model name='pcie-root-port'/>
        <target chassis='6' port='0x15'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x5'/>
      </controller>
      <controller type='pci' index='7' model='pcie-root-port'>
        <model name='pcie-root-port'/>
        <target chassis='7' port='0x16'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x6'/>
      </controller>
      <controller type='pci' index='8' model='pcie-to-pci-bridge'>
        <model name='pcie-pci-bridge'/>
        <address type='pci' domain='0x0000' bus='0x01' slot='0x00' function='0x0'/>
      </controller>
      <controller type='pci' index='9' model='pcie-root-port'>
        <model name='pcie-root-port'/>
        <target chassis='9' port='0x17'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x7'/>
      </controller>
      <controller type='virtio-serial' index='0'>
        <address type='pci' domain='0x0000' bus='0x03' slot='0x00' function='0x0'/>
      </controller>
      ${if vm.mountHome then ''
        <filesystem type='mount' accessmode='mapped'>
          <source dir='/home/${psCfg.user.name}'/>
          <target dir='/media/home'/>
          <address type='pci' domain='0x0000' bus='0x07' slot='0x00' function='0x0'/>
        </filesystem>
      '' else ""}
      <interface type='network'>
        <mac address='52:54:00:44:cd:ac'/>
        <source network='default'/>
        <model type='virtio'/>
        <address type='pci' domain='0x0000' bus='0x08' slot='0x01' function='0x0'/>
      </interface>
      <console type='pty'>
        <target type='serial' port='0'/>
      </console>
      <input type='tablet' bus='usb'>
        <address type='usb' bus='0' port='1'/>
      </input>
      <input type='mouse' bus='virtio'/>
      <input type='keyboard' bus='virtio'/>
      <graphics type='spice' autoport='yes' listen='127.0.0.1'>
        <listen type='address' address='127.0.0.1'/>
        <image compression='off'/>
      </graphics>
      <video>
        <model type='cirrus' vram='16384' heads='1' primary='yes'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x0'/>
      </video>
      ${if vm.handOverUSBDevices then ''
        <hostdev mode='subsystem' type='usb' managed='yes'>
          <source>
            <vendor id='0x046d'/>
            <product id='0xc328'/>
            <address bus='1' device='2'/>
          </source>
          <address type='usb' bus='0' port='4'/>
        </hostdev>
        <hostdev mode='subsystem' type='usb' managed='yes'>
          <source>
            <vendor id='0x046d'/>
            <product id='0xc52b'/>
            <address bus='1' device='3'/>
          </source>
          <address type='usb' bus='0' port='5'/>
        </hostdev>
      '' else ""}
      ${if vm.gpu && vm.isolateGPU != null then ''
        <hostdev mode='subsystem' type='pci' managed='yes'>
          <driver name='vfio'/>
          <source>
            <address domain='0x0000' bus='0x0b' slot='0x00' function='0x0'/>
          </source>
          <rom bar='on' file='/etc/nixos/hosts/chocolatebar/virtualisation/${vm.isolateGPU}.rom'/>
          <address type='pci' domain='0x0000' bus='0x06' slot='0x00' function='0x0' multifunction='on'/>
        </hostdev>
        <hostdev mode='subsystem' type='pci' managed='yes'>
          <driver name='vfio'/>
          <source>
            <address domain='0x0000' bus='0x0b' slot='0x00' function='0x1'/>
          </source>
          <address type='pci' domain='0x0000' bus='0x06' slot='0x00' function='0x1'/>
        </hostdev>
      '' else ""}
      <redirdev bus='usb' type='spicevmc'>
        <address type='usb' bus='0' port='2'/>
      </redirdev>
      <redirdev bus='usb' type='spicevmc'>
        <address type='usb' bus='0' port='3'/>
      </redirdev>
      <memballoon model='virtio'>
        <address type='pci' domain='0x0000' bus='0x05' slot='0x00' function='0x0'/>
      </memballoon>
      <shmem name='looking-glass'>
        <model type='ivshmem-plain'/>
        <size unit='M'>32</size>
      </shmem>
    </devices>
    <qemu:commandline>
      <qemu:arg value='-device'/>
      <qemu:arg value='ich9-intel-hda,bus=pcie.0,addr=0x1b'/>
      <qemu:arg value='-device'/>
      <qemu:arg value='hda-micro,audiodev=hda'/>
      <qemu:arg value='-audiodev'/>
      <qemu:arg value='pa,id=hda,server=unix:/run/user/1001/pulse/native'/>
    </qemu:commandline>
  </domain>
''
