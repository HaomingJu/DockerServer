FROM alpine:latest

WORKDIR /root

COPY repositories /etc/apk/repositories
RUN apk update && apk add --no-cache --virtual .runtime-deps rsync nginx
COPY entrypoint.sh /entrypoint.sh

RUN \
    echo "0 21 * * *    root    /usr/bin/rsync -avzh rsync://mirrors.tuna.tsinghua.edu.cn/ubuntu/ /root/ubuntu > /root/cron_ubuntu.log" >> /etc/crontabs/root && \
    echo "0 0 * * 7    root    /usr/bin/rsync -avzh rsync://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ /root/ros > /root/cron_ros.log" >> /etc/crontabs/root && \
    echo "0 6 * * 7    root    /usr/bin/rsync -avzh rsync://mirrors.tuna.tsinghua.edu.cn/ros2/ubuntu/ /root/ros2 > /root/cron_ros2.log" >> /etc/crontabs/root

CMD [ "/entrypoint.sh" ]
