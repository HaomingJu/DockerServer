FROM ubuntu:18.04

COPY sources.list /etc/apt/sources.list

RUN apt update && apt install -y gpg curl

# Infra 仓库认证
RUN curl http://10.11.100.8:8082/dists/trunk/pub.key | apt-key add -
# ROS 仓库认证
RUN gpg --keyserver keyserver.ubuntu.com --recv F42ED6FBAB17C654 && gpg --export --armor F42ED6FBAB17C654 | apt-key add -
# cmake 仓库认证
RUN gpg --keyserver keyserver.ubuntu.com --recv 6AF7F09730B3F0A4 && gpg --export --armor 6AF7F09730B3F0A4 | apt-key add -

RUN echo "deb http://10.11.100.8:8082/ trunk main" >> /etc/apt/sources.list
RUN echo "deb http://10.11.100.8:8081/ros/ubuntu bionic main" >> /etc/apt/sources.list
RUN echo "deb https://apt.kitware.com/ubuntu/ bionic main" >> /etc/apt/sources.list

RUN apt update && apt install -y cmake g++ gcc build-essential # ros-melodic-ros-base
