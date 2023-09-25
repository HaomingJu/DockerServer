FROM ubuntu:22.04

ENV http_proxy http://10.11.5.208:7890
ENV https_proxy http://10.11.5.208:7890

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY sources.list /etc/apt/sources.list

RUN apt update && apt install -y gpg curl g++ gcc build-essential zsh wget tig tree silversearcher-ag htop ssh universal-ctags unzip cargo npm rsync git language-pack-zh-hans

RUN npm install n -g

RUN n i 16

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN git clone --depth 1 https://github.com/junegunn/fzf.git $home/.fzf

RUN $home/.fzf/install --completion --key-bindings --all

RUN cargo install --locked navi

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$home/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
