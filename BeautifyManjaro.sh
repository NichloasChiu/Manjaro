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

VARI="$HOME/.icons/"
mkdir_func 
mv McMojave-circle-dark/ $VARI
mv McMojave-circle/ $VARI
mv McMojave-circle-light/  $VARI
mv WhiteSur/ $VARI
mv WhiteSur-dark/ $VARI
VARI="$HOME/.themes/"
mkdir_func 
mv Mojave-Light/ $VARI
mv WhiteSur-Light/ $VARI
