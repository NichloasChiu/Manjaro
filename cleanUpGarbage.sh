#!/bin/bash
###########################################################################################################
# File Name:    clean.sh
# Author:       NichloasChiu
# mail:         NichloasChiu@outlook.com
# Created Time: 2024年03月10日 星期日 13时46分00秒
##########################################################################################################
echo "testlolcat" | lolcat >/dev/null 2>&1
if [ $? -ne 0 ]; then
	sudo pacman -S lolcat --noconfirm
fi

sudo pacman -Sc --noconfirm

sudo pacman -Scc --noconfirm

sudo journalctl --vacuum-size=50M

function lolcat_command() {
	command=$1
	$command | lolcat
}

findPath=("/usr/local/bin/"
	"/usr/bin/"
	"/etc/"
	"$HOME/.config/"
	"/usr/share/"
	"/usr/local/share/"
	"$HOME/.cache/"
	"$HOME/.local/share/")
parameterHints=("echo Query executable file"
	"echo Query executable file"
	"echo Query configuration file"
	"echo Query personal data left"
	"echo Query leftover system data"
	"echo Query leftover system data"
	"echo Query leftover system data"
	"echo Query other related files"
	"echo Query other related files")
# 循环执行命令
function search_soft() {
	index=0
	for i in "${findPath[@]}"; do
		element="${parameterHints[$index]}"
		lolcat_command "$element:$i"
		index=$((index + 1))
		lolcat_command "echo #########################################################################################################################"
		if [[ "$i" == "/usr/bin/" || "$i" == "/usr/local/bin/" ]]; then
			sudo find "$i" -name "*$1*"
		else
			sudo find "$i" -type d -name "*$1*"
		fi
	done
}

if [ $# -eq 0 ]; then
	echo "If you need to query the cache, enter the parameter."
else
	while true; do
		search_soft $1
		read -p "Enter the folder path to be deleted (enter \"n\" to stop)" path
		clear
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
fi
