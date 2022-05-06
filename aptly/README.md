[#](#) 使用说明

### 1. 镜像构建

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

### REST API

软件包上传服务器
```
# UPLOAD FILE(S)
# POST /api/files/:dir
curl -X POST -F file=@ying_1.0.3_amd64.deb http://10.11.100.8:8083/api/files/ying
```


将软件包加入到仓库中
```
# ADD PACKAGES FROM UPLOADED FILE/DIRECTORY
# POST /api/repos/:name/file/:dir
# POST /api/repos/:name/file/:dir/:file
curl -X POST http://10.11.100.8:8083/api/repos/infra_`lsb_release -s -c`/file/ying
```

更新软件源，之后apt update将生效
```
# UPDATE PUBLISHED LOCAL REPO/SWITCH PUBLISHED SNAPSHOT
# PUT /api/publish/:prefix/:distribution
curl -X PUT http://10.11.100.8:8083/api/publish/trunk/`lsb_release -s -c`
```

更新本地软件列表
```
sudo apt update
```

在遇到软件包上传失败等混乱问题时, 可以登陆容器内进行操作:

1. 杀掉aptly server 进程
2. aptly repo remove -dry-run [repo_name] '[query_deb]' 例子(aptly repo remove -dry-run infra_xenial 'rttr')
3. 重启 aptly server 服务

[] 仓库发布时的前缀 prefix
[] REST API nginx处http认证
