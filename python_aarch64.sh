#!/bin/sh


install_anaconda() {
      # Define the URL for the Anaconda installer
      ANA_CONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-aarch64.sh"

      # Define the destination file path
      DEST_FILE="$HOME/Anaconda3-2024.06-1-Linux-aarch64.sh"

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