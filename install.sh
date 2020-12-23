# scripts come from https://markuta.com/how-to-build-a-mips-qemu-image-on-debian/

wget http://ftp.debian.org/debian/dists/stable/main/installer-mips/current/images/malta/netboot/initrd.gz

wget http://ftp.debian.org/debian/dists/stable/main/installer-mips/current/images/malta/netboot/vmlinux-4.19.0-11-4kc-malta



# create the hard drive
qemu-img create -f qcow2 hda.img 10G

# start the installer
qemu-system-mips -M malta \
  -m 1024 -hda hda.img \
  -kernel vmlinux-4.19.0-11-4kc-malta \
  -initrd initrd.gz \
  -append "console=ttyS0 nokaslr" \
  -nographic

#once the install has completed

mkdir -p /tmp/mnt/mipsMount
sudo modprobe nbd max_part=63
sudo qemu-nbd -c /dev/nbd0 hda.img
sudo mount /dev/nbd0p1 /tmp/mnt/mipsMount

cp -r /tmp/mnt/mipsMount/boot/* .

sudo umount /tmp/mnt/mipsMount
sudo qemu-nbd -d /dev/nbd0

rm -rf /tmp/mnt/mipsMount
