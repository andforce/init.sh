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
    git config --global user.name "diyuan"
    git config --global user.email "86118@163.com"
    git config --global core.editor vim
    git config --global alias.st status
    git config --global alias.co checkout
    git config --global alias.ci commit
    git config --global alias.br branch
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

    # 检查 ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 是否存在
    if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
        echo "zsh-syntax-highlighting 已安装"
    else
        echo "下载安装 zsh-syntax-highlighting 插件"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi

    if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
        echo "zsh-autosuggestions 已安装"
    else
        echo "下载安装 zsh-autosuggestions 插件"
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi

    sed -i 's@plugins=(.*)@plugins=(git extract zsh-syntax-highlighting zsh-autosuggestions)@g' ~/.zshrc

    #    {
    #        echo 'alias cat="/usr/bin/bat"'
    #        echo 'alias myip="curl ifconfig.io/ip"'
    #        echo 'alias c=clear'
    #    } >>~/.zshrc
}

install_zsh