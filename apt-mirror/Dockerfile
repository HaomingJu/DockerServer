FROM     ubuntu:18.04

# 更新软件源
RUN apt-get update
RUN apt-get install -y perl cron nginx-light

# 复制修复之后的apt-mirror
COPY apt-mirror /usr/bin/apt-mirror

# 复制入口脚本
COPY entrypoint.sh /entrypoint.sh

## 更新apt-mirror的路径和定时任务的配置文件
COPY mirror.list /etc/apt/mirror.list
RUN echo "* 23 * * *    root    /usr/bin/apt-mirror > /root/cron.log" >> /etc/crontab

# 安装nginx, 为了用http协议发布自建仓库
COPY apt-mirror.conf /etc/nginx/conf.d/apt-mirror.conf

CMD [ "/entrypoint.sh" ]
