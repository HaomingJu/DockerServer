#!/usr/bin/env bash

repo_architectures=amd64
repo_component=main
repo_distribution=trunk
repo_name=infra

# 快捷生成gpg密钥对(https://www.gnupg.org/documentation/manuals/gnupg/OpenPGP-Key-Management.html)
gpg --batch --passphrase "" \
    --quick-generate-key "aptly (key for aptly) <aptly@aptly.info>" rsa1024 default never

# 清理数据库
rm /root/.aptly/* -rf

# 创建仓库
aptly repo create -architectures="${repo_architectures}" -component="${repo_component}" -distribution="${repo_distribution}" ${repo_name}

# 发布仓库
aptly publish repo -architectures="${repo_architectures}" ${repo_name}

# 参考: https://www.aptly.info/doc/api/
# nginx托管
aptly serve -listen=0.0.0.0:8081 &

# 启动API服务
aptly api serve -listen=0.0.0.0:8082 &

# 防止脚本结束, 防止了容器执行完脚本自动关闭
tail -f /dev/null