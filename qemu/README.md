
# 简介

交叉编译时可以采用Docker+QEMU的方案

官方提供了一些标准的使用方式, 诸如:

https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/

https://github.com/multiarch/qemu-user-static

但是以镜像arm64v8/ubuntu为基础的方案虽然可行, 但是实际使用过程中编译速度比较慢

优势是不需要使用工具链配置(ToolChain.cmake等)


**在实际应用中以在Docker中安装QEMU并配置交叉编译工具链的方式效果较好**


