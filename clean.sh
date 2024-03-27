#!/bin/bash
###########################################################################################################
# File Name:    clean.sh
# Author:       NichloasChiu
# mail:         NichloasChiu@outlook.com
# Created Time: 2024年03月10日 星期日 13时46分00秒
##########################################################################################################
sudo pacman -Sc --noconfirm
sudo pacman -Scc --noconfirm
sudo journalctl --vacuum-size=50M

function search_soft() {
	clear
	echo "Query personal data left"
	find ~/.config/ -type d -name "*$1*"
	echo "---------------------------------------------------------------------------------------------------------------------------"
	echo "Query leftover system data"
	echo "---------------------------------------------------------------------------------------------------------------------------"
	sudo find /usr/share -type d -name "*$1*"
	sudo find /usr/lib/ -type d -name "*$1*"
	echo "Query other related files"
	echo "---------------------------------------------------------------------------------------------------------------------------"
	find ~/.cache/ -type d -name "*$1*"
	find ~/.local/share/ -type d -name "*$1*"
}

while true; do
	search_soft $1
	read -p "Enter the folder path to be deleted (enter \"n\" to stop)" path
	if [ "$path" = "n" ]; then
		echo "Deleted."
		break
	fi

	if [ -d "$path" ]; then
		rm -rf "$path"
		echo "Deleted folders: $path"
		clear

	else
		echo "The folder does not exist：$path"
	fi
done
