#!/bin/sh

# zsh安装
config_zsh() {
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

    echo "$HOME   *(rw,async,insecure,no_subtree_check,all_squash,anonuid=0,anongid=0)" | sudo tee -a /etc/exports > /dev/null
}

config_zsh

# 系统配置
system_config() {
    echo "apt install ag ..."
    sudo apt-get install -y tmux
    sudo apt-get install -y vim
    sudo apt-get install -y unzip
    sudo apt-get install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
    # 编译aosp需要的依赖
    sudo apt-get install libncurses5
    # 安装NFS相关的
    sudo apt-get install -y rpcbind
    sudo apt-get install -y nfs-server
    sudo systemctl enable rpcbind nfs-server
    sudo systemctl start rpcbind nfs-server
    # 把当前用户加入到nfs共享目录
    echo "$HOME   *(rw,async,insecure,no_subtree_check,all_squash,anonuid=0,anongid=0)"

    # ssh
    sudo apt-get install -y openssh-server

}

system_config


install_anaconda() {
      # Define the URL for the Anaconda installer
      ANA_CONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh"

      # Define the destination file path
      DEST_FILE="$HOME/Anaconda3-2024.06-1-Linux-x86_64.sh"

      # Download the installer script to the specified destination
      curl -fSL "$ANA_CONDA_URL" -o "$DEST_FILE"

      # Grant execution permissions to the installer script
      chmod +x "$DEST_FILE"

      # Execute the installer script
      "$DEST_FILE"
}

python_config() {
    sudo apt-get install -y python3
    sudo apt-get install -y python3-pip
    sudo apt-get install -y python3-venv
    sudo apt-get install -y python3-dev
    sudo apt-get install -y python3-setuptools
    sudo apt-get install -y python3-wheel
    # 如果python 不存在，就做软连接
    if [ ! -f /usr/bin/python ]; then
        sudo ln -s /usr/bin/python3 /usr/bin/python
    fi

    # 查看 conda --version 执行结果，判断是否安装了 Anaconda
    if [ -z "$(command -v conda)" ]; then
        echo "安装 Anaconda"
        install_anaconda
    else
        echo "Anaconda 已安装"
    fi

}

python_config

java_config() {
    curl -s "https://get.sdkman.io" | bash
    # source "$HOME/.sdkman/bin/sdkman-init.sh"
    # 把 "$HOME/.sdkman/bin/sdkman-init.sh" 放到 ~/.zshrc 中
    echo "source \"$HOME/.sdkman/bin/sdkman-init.sh\"" >> ~/.zshrc
    echo "配置完成，请重新登录或者执行 source ~/.zshrc"
    # sdk list java  # 列出所有可用的JDK版本
    # sdk install java 11.0.11.hs-adpt  # 安装特定版本的JDK
    # sdk use java 11.0.11.hs-adpt  # 切换到特定版本的JDK
    # sdk install java 11.0.14.1-jbr
}

java_config