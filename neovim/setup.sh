#!/usr/bin/env bash

# 1. 全局变量
home=/root
codename=bionic
arch=$(dpkg --print-architecture)
path_cfg_neovim=$home/.config/nvim
path_cfg_cheats=$home/.config/Cheats
path_cfg_snippets=$home/.config/Snippets

# 2. 安装额外源
apt update && apt-get install -y software-properties-common
add-apt-repository -y -n ppa:neovim-ppa/unstable
add-apt-repository -y -n ppa:git-core/ppa

apt update && apt install -y \
	neovim git zsh curl wget\
        tig tree silversearcher-ag htop ssh ctags unzip\
        aptitude cargo \
        docker docker.io \
	gcc g++ \
        nodejs-dev node-gyp libssl1.0-dev \
	npm \
	python3.8* python3-pip \
	language-pack-zh-hans

# 3. 应用配置
## 3.1 neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim $home/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/HaomingJu/neovimCfg.git 	$path_cfg_neovim
git clone https://github.com/HaomingJu/Cheats.git 	$path_cfg_cheats
git clone https://github.com/HaomingJu/Snippets.git 	$path_cfg_snippets

## 3.2 oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

## 3.3 fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $home/.fzf
$home/.fzf/install --completion --key-bindings --all

## 3.4 navi
cargo install --locked navi

## 3.5 autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$home/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

## 3.6 npm
npm install n -g
n i 16

## 3.7 python3.8
python3.8 -m pip install pip --upgrade
python3.8 -m pip install pynvim
python3.8 -m pip install --user --upgrade pynvim

## 3.8 clangd
wget https://github.com/clangd/clangd/releases/download/15.0.6/clangd-linux-15.0.6.zip -O /root/clangd-linux-15.0.6.zip
pushd /root
    unzip clangd-linux-15.0.6.zip
    cp clangd_15.0.6/bin/clangd /usr/bin/clangd
    cp clangd_15.0.6/lib/* /usr/lib/ -rf
    rm clangd* -rf
popd

# 定时任务配置
