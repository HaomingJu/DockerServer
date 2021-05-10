FROM     ubuntu:18.04

MAINTAINER Haoming.Ju "juhaoming@outlook.com"

# 更新软件源
RUN apt-get update
RUN apt-get install -y apt-mirror cron nginx-light

## 更新apt-mirror的路径和定时任务的配置文件
COPY ./mirror.list /etc/apt/mirror.list
COPY ./apt-mirror /etc/cron.d/apt-mirror

# 安装nginx, 为了用http协议发布自建仓库
COPY ./apt-mirror.conf /etc/nginx/conf.d/apt-mirror.conf
RUN nginx -t
RUN service nginx start

EXPOSE 80
CMD nginx -g "daemon off;" #后台运行nginx命令，在运行容器时执行
