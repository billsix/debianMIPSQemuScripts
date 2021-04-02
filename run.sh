qemu-system-mips -M malta \
  -m 1024 -hda hda.img \
  -kernel vmlinux-4.19.0-16-4kc-malta \
  -initrd initrd.img-4.19.0-16-4kc-malta \
  -append "root=/dev/sda1 console=ttyS0 nokaslr" \
  -nographic \
  -net user,hostfwd=tcp::10022-:22 \
  -net nic
