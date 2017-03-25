#!/bin/bash

make px4fmuv4_bl || exit 1

#PORT=/dev/ttyACM0
PORT=/dev/serial/by-id/usb-Black_Sphere_Technologies_Black_Magic_Probe_DDD5C5DE-if00

elf=px4fmuv4_bl.elf

arm-none-eabi-size $elf || exit 1

tmpfile=fwupload.tempfile
cat > $tmpfile <<EOF
target extended-remote $PORT
mon swdp_scan
attach 1
load
kill
EOF

arm-none-eabi-gdb $elf --batch -x $tmpfile
rm $tmpfile
