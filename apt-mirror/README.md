# 使用说明

### 1. 镜像构建

```
sudo docker build -t apt-mirror:latest ./

```
### 2. 运行容器
```
sudo docker run -it -d \
    -p 8081:8081 \
    -v /media/haoming/data:/root \
    -v /etc/timezone:/etc/timezone:ro \
    -v /etc/localtime:/etc/localtime:ro \
    --name server-apt-mirror \
    --restart=always \
    apt-mirror:latest
```

### 3. 时间表达式
请参考: https://www.matools.com/crontab
