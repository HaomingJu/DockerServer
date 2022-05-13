取得节点信息, 保存至`config.json`文件中

注意在docker中`local_addr`字段要为`0.0.0.0`

**创建镜像**
```
sudo docker build . -t alpine:trojan
```

**启动实例**
```
sudo docker run -it -d -p 1080:1080 --restart=always --name trojan alpine:trojan
```

使用时,可以设置环境变量
```
# 设置代理
export http_proxy=socks5://127.0.0.1:1080
export https_proxy=socks5://127.0.0.1:1080

# 恢复直连
unset http_proxy
unset https_proxy
```

测试:
```
curl www.google.com
```
