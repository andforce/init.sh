#!/bin/sh

config_sdk() {

    # 判断 ~/.zshrc 文件中是否已经存在 ANDROID_HOME 和 PATH
    if grep -q "export ANDROID_HOME=~/android-sdk-linux" ~/.zshrc; then
        echo "ANDROID_HOME 已存在"
    else
        curl -fSL https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -o ~/android-sdk.tgz
        tar -xvzf ~/android-sdk.tgz -C ~/
        {
            echo "export ANDROID_HOME=~/android-sdk-linux"
            echo "export PATH=\$PATH:\$ANDROID_HOME/tools"
            echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools"
        } >> ~/.zshrc
    fi

     android update sdk --no-ui
}

config_sdk