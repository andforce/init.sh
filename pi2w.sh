#!/bin/sh

sudo apt install git net-tools -y
sudo systemctl stop ModemManager
sudo systemctl disable ModemManager.service
sudo systemctl list-dependencies multi-user.target | grep Modem
