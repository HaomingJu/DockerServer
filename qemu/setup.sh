# Please run this script in container(runner) as root, PS: --privileged
# Do not exec this script repeatedly, otherwise the sysroot would be reset

# install qemu-deboostrap
apt update && apt install -y lsb-release debootstrap qemu-user-static schroot
qemu-debootstrap --arch=arm64 `lsb_release -s -c` /root/arm64-ubuntu http://192.168.3.248:8081/artifactory/ubuntu-ports

# add chroot config
echo "[arm64-ubuntu]
description=Ubuntu 18.04 Bionic (arm64)
directory=/root/arm64-ubuntu
root-users=root
users=root
type=directory" | tee /etc/schroot/chroot.d/arm64-ubuntu

# change sources for schroot
echo "deb http://192.168.3.248:8081/artifactory/ubuntu-ports/ bionic main restricted universe multiverse
deb http://192.168.3.248:8081/artifactory/ubuntu-ports/ bionic-updates main restricted universe multiverse
deb http://192.168.3.248:8081/artifactory/ubuntu-ports/ bionic-backports main restricted universe multiverse
deb http://192.168.3.248:8081/artifactory/ubuntu-ports/ bionic-security main restricted universe multiverse" > /root/arm64-ubuntu/etc/apt/sources.list

# exec steps in chroot
EXEC_IN_SCHROOT="schroot -c arm64-ubuntu -u root /bin/bash"

# fix apt error
echo "sed -i '/crontab/d' /var/lib/dpkg/statoverride" | $EXEC_IN_SCHROOT
echo "sed -i '/messagebus/d' /var/lib/dpkg/statoverride" | $EXEC_IN_SCHROOT

# update
echo "apt update --fix-missing && apt install -y gpg tzdata" | $EXEC_IN_SCHROOT

# add ros2 key
echo "gpg --keyserver keyserver.ubuntu.com --recv F42ED6FBAB17C654 && \
	gpg --armor --export F42ED6FBAB17C654 | apt-key add -" | $EXEC_IN_SCHROOT

# add ros2 source
echo "echo 'deb [arch=arm64] http://192.168.3.248:8081/artifactory/ros2 bionic main' >> /etc/apt/sources.list" | $EXEC_IN_SCHROOT

# install build env for cross-compile
echo "apt update --fix-missing && apt install -y ros-dashing-ros-base ros-dashing-example-interfaces" | $EXEC_IN_SCHROOT

# rosdep
apt install -y python3-bloom python3-rosdep fakeroot dh-make
echo "185.199.111.133 raw.githubusercontent.com" >> /etc/hosts
rosdep init && rosdep update

# fix Poco pre-built link error, see https://docs.ros.org/en/dashing/Guides/Cross-compilation.html
ln -s /root/arm64-ubuntu/lib/aarch64-linux-gnu/libz.so.1 /usr/lib/aarch64-linux-gnu/libz.so
ln -s /root/arm64-ubuntu/lib/aarch64-linux-gnu/libpcre.so.3 /usr/lib/aarch64-linux-gnu/libpcre.so
