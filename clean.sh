#!/bin/bash
###########################################################################################################
# File Name:    clean.sh
# Author:       NichloasChiu
# mail:         NichloasChiu@outlook.com
# Created Time: 2024年03月10日 星期日 13时46分00秒
##########################################################################################################
sudo pacman -Sc --noconfirm
sudo pacman -Scc --noconfirm
sudo journalctl --vacuum-size=100M
