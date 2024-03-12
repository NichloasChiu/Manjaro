#!/bin/bash
###########################################################################################################
# File Name:    BeautifyManjaro.sh
# Author:       NichloasChiu
# mail:         NichloasChiu@outlook.com
# Created Time: 2024年02月27日 星期四 22时26分06秒
##########################################################################################################
if_mycmd() {
	if [ $? -ne 0 ]; then
		echo "The script exits, and an unexpected situation occurs, please configure it manually"
		exit
	fi
}
mkdir_func() {
	if [ ! -e $VARI ]; then
		mkdir -p $VARI
	fi
}

cd ~/WorkingDocument/Manjaro/ || exit
tar -xf Mojave-Light-themes.tar.xz
if_mycmd

tar -xf WhiteSurIcon.tar.xz
if_mycmd

tar -xf WhiteSur-Light-themes.tar.xz
if_mycmd

tar -xf 01-McMojave-circle-icons.tar.xz
if_mycmd

tar -xf WhiteSur-cursors.tar.xz
if_mycmd

VARI="$HOME/.icons/"
mkdir_func
cp -rf ~/WorkingDocument/Manjaro/McMojave-circle-dark/ $VARI
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/McMojave-circle/ $VARI
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/McMojave-circle-light/ $VARI
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/WhiteSur/ $VARI
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/WhiteSur-cursors/ $VARI
if_mycmd

VARI="$HOME/.themes/"
mkdir_func
cp -rf ~/WorkingDocument/Manjaro/Mojave-Light/ $VARI
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/WhiteSur-Light/ $VARI
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/WhiteSur-dark/ $VARI
if_mycmd

# Delete cashe
cd ~/WorkingDocument/Manjaro/ || exit
rm -rf WhiteSur Mojave-Light McMojave-circle-light McMojave-circle-dark McMojave-circle WhiteSur-dark WhiteSur-Light WhiteSur-cursors
