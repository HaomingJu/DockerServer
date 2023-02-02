FROM ubuntu:18.04

COPY sources.list /etc/apt/sources.list

COPY setup.sh /root/

RUN cd /root && ./setup.sh

COPY conf/zshrc /root/.zshrc

COPY conf/tigrc /root/.tigrc

COPY conf/tigrc.theme /root/.tigrc.theme

