#!/usr/bin/sh

install_zsh() {
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
