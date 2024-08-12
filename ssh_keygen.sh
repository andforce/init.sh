#!/bin/sh

# 系统配置
ssh_keygen() {


    if ! grep -Fxq "    eval \"\$(ssh-agent -s)\"" $HOME/.zshrc; then
        # 如果没有找到，则追加到文件中
        {
          echo "if ! pgrep -u \"\$USER\" ssh-agent > /dev/null; then
    eval \"\$(ssh-agent -s)\"
fi"
        } >> ~/.zshrc
    else
        echo "条目已存在，无需追加。"
    fi


#    if ! grep -Fxq "eval \"\$(ssh-agent -s)\"" $HOME/.bashrc; then
#        # 如果没有找到，则追加到文件中
#        {
#          echo "if ! pgrep -u \"\$USER\" ssh-agent > /dev/null; then
#    eval \"\$(ssh-agent -s)\"
#fi"
#        } >> ~/.bashrc
#    else
#        echo "条目已存在，无需追加。"
#    fi



#    add="ssh-add $HOME/.ssh/id_ed25519"
#
#    if ! grep -Fxq "$add" $HOME/.zshrc; then
#        # 如果没有找到，则追加到文件中
#        echo "$add" | sudo tee -a $HOME/.zshrc
#    else
#        echo "条目已存在，无需追加。"
#    fi
#
#    if ! grep -Fxq "$add" $HOME/.bashrc; then
#            # 如果没有找到，则追加到文件中
#        echo "$add" | sudo tee -a $HOME/.bashrc
#    else
#        echo "条目已存在，无需追加。"
#    fi

}

ssh_keygen