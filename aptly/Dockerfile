FROM     ubuntu:18.04

# 更新软件源

RUN echo "deb http://repo.aptly.info/ squeeze main" >> /etc/apt/sources.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A0546A43624A8331

RUN apt-get update && apt install aptly

# 复制入口脚本
COPY entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh" ]
