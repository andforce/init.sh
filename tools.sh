#!/bin/sh

# 系统配置
tools() {
    echo "apt install ag ..."
    sudo apt-get install -y tmux
    sudo apt-get install -y vim
    sudo apt-get install -y unzip
    # ssh
    sudo apt-get install -y openssh-server

}

tools