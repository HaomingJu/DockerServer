#!/usr/bin/env bash

repo_architectures=amd64
repo_component=main
repo_name=infra
pub_prefix=trunk

# 快捷生成gpg密钥对(https://www.gnupg.org/documentation/manuals/gnupg/OpenPGP-Key-Management.html)
gpg --batch --passphrase "" \
    --quick-generate-key "aptly (key for aptly) <aptly@aptly.info>" rsa1024 default never


{
    aptly repo create -architectures=${repo_architectures} -component=${repo_component} -distribution=xenial ${repo_name}_xenial
} || {
    echo "create xenial repo failed. (for 16.04 LTS)"
}
{
    aptly repo create -architectures=${repo_architectures} -component=${repo_component} -distribution=bionic ${repo_name}_bionic
} || {
    echo "create bionic repo failed. (for 18.04 LTS)"
}
{
    aptly repo create -architectures=${repo_architectures} -component=${repo_component} -distribution=focal ${repo_name}_focal
} || {
    echo "create focal repo failed. (for 20.04 LTS)"
}
{
    aptly repo create -architectures=${repo_architectures} -component=${repo_component} -distribution=jammy ${repo_name}_jammy
} || {
    echo "create jammy repo failed. (for 22.04 LTS)"
}


{
    aptly publish repo -architectures=${repo_architectures} ${repo_name}_xenial ${pub_prefix}
} || {
    echo "publis repo ${repo_name}_xenial failed. (for 16.04 LTS)"
}
{
    aptly publish repo -architectures=${repo_architectures} ${repo_name}_bionic ${pub_prefix}
} || {
    echo "publis repo ${repo_name}_bionic failed. (for 18.04 LTS)"
}
{
    aptly publish repo -architectures=${repo_architectures} ${repo_name}_focal ${pub_prefix}
} || {
    echo "publis repo ${repo_name}_focal failed. (for 20.04 LTS)"
}
{
    aptly publish repo -architectures=${repo_architectures} ${repo_name}_jammy ${pub_prefix}
} || {
    echo "publis repo ${repo_name}_jammy failed. (for 22.04 LTS)"
}

# 参考: https://www.aptly.info/doc/api/
# nginx托管
aptly serve -listen=0.0.0.0:8081 &

# 发布公钥
#gpg --output /root/.aptly/public/${pub_prefix}/dists/pub.key --armor --export aptly

# 启动API服务
aptly api serve -listen=0.0.0.0:8082 &

# 防止脚本结束, 防止了容器执行完脚本自动关闭
tail -f /dev/null
