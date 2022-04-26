[#](#) 使用说明

[###](###) 1. 镜像构建

```
sudo docker build -t aptly:latest ./

```
### 2. 运行容器
```
sudo docker run -it -d \
    -p 8081:8081 \
    -p 8082:8082 \
    -v /mnt/sdb:/root \
    -v /etc/timezone:/etc/timezone:ro \
    -v /etc/localtime:/etc/localtime:ro \
    --name ubuntu_repo \
    --restart=always \
    aptly:latest
```
