#!/bin/sh
set -x
DATE=$(date +%Y%m%d_%H%M)

export QEMU_DIR='/home/yuhyu/QEMU-LVZ'

RAMDISK_CMD='console=tty console=ttyS0,115200 earlycon=uart,mmio,0x1fe001e0 rdinit=/init loglevel=8'
RAMDISK="-kernel ${QEMU_DIR}/vmlinuz.efi -initrd ${QEMU_DIR}/rootfs.img -append"

${QEMU_DIR}/build/qemu-system-loongarch64 \
	-m 4G \
	-cpu la464,lvz=off \
	-machine virt \
	-nographic \
	-bios ${QEMU_DIR}/QEMU_EFI.fd \
	-serial mon:stdio \
	-smp 4 \
	-object memory-backend-ram,id=m0,size=2G \
	${RAMDISK} "${RAMDISK_CMD}" 

set +x