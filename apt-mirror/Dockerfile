FROM     ubuntu:18.04

# 更新软件源
COPY sources.list /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y perl wget cron nginx-light

# 复制修复之后的apt-mirror
COPY apt-mirror /usr/bin/apt-mirror

# 复制入口脚本
COPY entrypoint.sh /entrypoint.sh

## 更新apt-mirror的路径和定时任务的配置文件(0 1 * * 7 每周日凌晨1点进行计划任务)
COPY mirror.list /etc/apt/mirror.list
RUN echo "0 1 * * 1,3,5    root    /usr/bin/apt-mirror > /root/cron.log" >> /etc/crontab
RUN ln -s /etc/crontab /root/crontab

# 安装nginx, 为了用http协议发布自建仓库 
COPY apt-mirror.conf /etc/nginx/conf.d/apt-mirror.conf

CMD [ "/entrypoint.sh" ]
