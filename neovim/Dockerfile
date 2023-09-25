FROM ubuntu:dev22.04

ENV http_proxy http://10.11.5.208:7890
ENV https_proxy http://10.11.5.208:7890

WORKDIR /root

RUN apt update && apt-get install -y software-properties-common
RUN add-apt-repository -y -n ppa:neovim-ppa/unstable
RUN add-apt-repository -y -n ppa:git-core/ppa

RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim /root/.local/share/nvim/site/pack/packer/start/packer.nvim
RUN git clone https://github.com/HaomingJu/neovimCfg.git        /root/.config/nvim
RUN git clone https://github.com/HaomingJu/Cheats.git           /root/.config/Cheats
RUN git clone https://github.com/HaomingJu/Snippets.git 	/root/.config/Snippets

RUN wget https://github.com/clangd/clangd/releases/download/15.0.6/clangd-linux-15.0.6.zip -O /root/clangd-linux-15.0.6.zip
RUN unzip clangd-linux-15.0.6.zip && \
    cp clangd_15.0.6/bin/clangd /usr/bin/clangd && \
    cp clangd_15.0.6/lib/* /usr/lib/ -rf && \
    rm clangd* -rf

RUN apt update && apt install -y neovim python3-pip
RUN python3 -m pip install --user --upgrade pynvim

ENTRYPOINT [ "tail", "-f", "/dev/null" ]
