FROM ubuntu:18.04

ENV http_proxy http://10.11.2.254:7890

ENV https_proxy http://10.11.2.254:7890

COPY sources.list /etc/apt/sources.list

COPY setup.sh /root/

RUN cd /root && ./setup.sh

COPY conf/zshrc /root/.zshrc

COPY conf/tigrc /root/.tigrc

COPY conf/tigrc.theme /root/.tigrc.theme

