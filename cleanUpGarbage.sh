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

package_name=""
uninstall_flag=""

if [[ "$1" == "-u" ]]; then
	package_name="$2"
elif [[ "$2" == "-u" ]]; then
	package_name="$1"
fi

# Analysis parameter
for arg in "$@"; do
	if [ "$arg" = "-u" ]; then
		uninstall_flag="y"
	fi
done

# Search and uninstall with Pacman
if [ "$uninstall_flag" = "y" ]; then
	if pacman -Qs "$package_name" >/dev/null; then
		echo "Pacman software package has been installed, the search results are as follows:"
		sudo pacman -Qs "$package_name"
		read -p "Please enter the full name of the software package to be uninstalled:" package_to_remove
		sudo pacman -Rns "$package_to_remove"
	else
		search_result=$(yay -Qs "$package_name")
		if [ -z "$search_result" ]; then
			echo "No software package was found"
		else
			echo "The software package is not installed in PACMAN, and you will try to search with Yay"
			yay -Qs $package_name
			read -p "Please enter the full name of the software package to be uninstalled:" package_to_remove
			echo "Find the software package, you will try to uninstall it with yay"
			yay -Rns "$package_to_remove"
		fi
	fi
fi

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
