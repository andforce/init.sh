#!/bin/sh

java_config() {
    curl -s "https://get.sdkman.io" | bash
    # source "$HOME/.sdkman/bin/sdkman-init.sh"
    # 把 "$HOME/.sdkman/bin/sdkman-init.sh" 放到 ~/.zshrc 中
    echo "source \"$HOME/.sdkman/bin/sdkman-init.sh\"" >> ~/.zshrc
    # shellcheck disable=SC3046
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    echo "配置完成，请重新登录或者执行 source ~/.zshrc"
    # sdk list java  # 列出所有可用的JDK版本
    # sdk install java 11.0.11.hs-adpt  # 安装特定版本的JDK
    # sdk use java 11.0.11.hs-adpt  # 切换到特定版本的JDK
    # sdk install java 11.0.14.1-jbr
    echo "安装特定版本的JDK:"
    echo "sdk list java"
    echo "sdk install java 11.0.11.hs-adpt"
    echo "sdk use java 11.0.11.hs-adpt"

}

java_config