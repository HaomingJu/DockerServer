FROM     ubuntu:18.04

ARG repo_architectures=amd64
ARG repo_component=main
ARG repo_distribution=trunk
ARG repo_name=infra

ENV GIN_MODE=release

COPY sources.list /etc/apt/sources.list

RUN apt update && apt install -y gnupg

RUN echo "deb http://repo.aptly.info/ squeeze main" >> /etc/apt/sources.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A0546A43624A8331

RUN apt update && apt install -y aptly && aptly config show

# 复制入口脚本
COPY entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh" ]
