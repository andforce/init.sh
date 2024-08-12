#!/usr/bin/sh

install_git() {
  # 检查是否安装了 git
    if [ -z "$(command -v git)" ]; then
        echo "安装 git"
        sudo apt-get install -y git
    else
        echo "git 已安装"
    fi

    echo "配置 git"
    # 等待用户输入用户名和邮箱
    echo "请输入用户名，git config --global user.name: "
    read -r username
    echo "请输入邮箱，git config --global user.email: "
    read -r email
    git config --global user.name "$username"
    git config --global user.email "$email"
    git config --global core.editor vim
    git config --global alias.st status
    git config --global alias.co checkout
    git config --global alias.ci commit
    git config --global alias.br branch
    git config --global pager.branch false
}

install_git