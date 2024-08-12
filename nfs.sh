#!/bin/sh

# 系统配置
system_config() {
    echo "apt install ag ..."
    # 安装NFS相关的
    sudo apt-get install -y rpcbind
    sudo apt-get install -y nfs-server
    sudo systemctl enable rpcbind nfs-server
    sudo systemctl start rpcbind nfs-server

    # 创建 $HOME/nfs，如果不存在就创建
#    if [ ! -d "$HOME/nfs" ]; then
#        mkdir -p "$HOME/nfs"
#    fi

    # 把当前用户加入到nfs共享目录 sudo vi /etc/exports
    # 要写入的内容
    export_entry="$HOME   *(rw,async,insecure,no_subtree_check,all_squash,anonuid=0,anongid=0)"

    # 检查 /etc/exports 文件中是否已经包含了这个条目
    if ! grep -Fxq "$export_entry" /etc/exports; then
        # 如果没有找到，则追加到文件中
        echo "$export_entry" | sudo tee -a /etc/exports
    else
        echo "条目已存在，无需追加。"
    fi

    echo "重启系统生效"


}

system_config