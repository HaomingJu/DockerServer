#!/bin/sh

crond
nginx

# 防止脚本结束, 防止了容器执行完脚本自动关闭
tail -f /dev/null
