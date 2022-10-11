FROM ubuntu:18.04

ENV LANG C.UTF-8

ENV DEBIAN_FRONTEND=noninteractive

# install build env for cross-compile
RUN apt update --fix-missing && apt install -y curl cmake crossbuild-essential-arm64 pkg-config-aarch64-linux-gnu

# copy sysroot setup script into container
COPY sysroot_setup.sh /root

WORKDIR /root
