GPU_VGA_PORT="0000:01:00.0"

echo 1 > "/sys/bus/pci/devices/$GPU_VGA_PORT/rom"
cat "/sys/bus/pci/devices/$GPU_VGA_PORT/rom" > \
"/usr/share/qemu/gpu-1060.rom"
echo 0 > "/sys/bus/pci/devices/$GPU_VGA_PORT/rom"

