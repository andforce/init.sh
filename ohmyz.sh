#!/usr/bin/sh

# 强制交互式模式
if [ -z "$PS1" ]; then
    export PS1="ssh-remote$ "
fi

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

install_zsh() {
    install_git

    echo "安装 ohmyzsh，官方网站：https://ohmyz.sh"
    # 检查是否安装了 zsh
    if [ -z "$(command -v zsh)" ]; then
        echo "安装 zsh"
        sudo apt-get install -y zsh
    fi

    is_need_install_ohmyzsh=0
    # 检查 ~/.oh-my-zsh 目录是否存在
    if [ -d ~/.oh-my-zsh ]; then
        echo "ohmyzsh 已安装. 重新安装? [Y/n]"
        read -r answer
        case "$answer" in
            [Yy]|"")
                echo "重新安装 ohmyzsh"
                rm -f -r ~/.oh-my-zsh
                is_need_install_ohmyzsh=1
                ;;
            *)
                echo "跳过重新安装"
                ;;
        esac
    else
        is_need_install_ohmyzsh=1
    fi


    if [ $is_need_install_ohmyzsh -eq 1 ]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi


    # https://www.cnblogs.com/highriver/archive/2011/10/30/2229503.html
    # 设置输入法可以输入中文，当前环境是英文
    {
        echo 'export LC_CTYPE=zh_CN.UTF-8'
        echo 'export LANG=en_US.UTF-8'
    } >>~/.zshrc
}

install_zsh
