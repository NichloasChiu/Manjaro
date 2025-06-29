#!/bin/bash
###########################################################################################################
# File Name:    BeautifyManjaro.sh
# Author:       NichloasChiu
# mail:         NichloasChiu@outlook.com
# Created Time: 2024年02月27日 星期四 22时26分06秒
##########################################################################################################
set -e # 遇到错误时退出

# 配置
FONT_SRC_DIR="$HOME/WorkingDocument/Manjaro/JetBrainsMono" # 字体源目录
FONT_DIR="$HOME/.local/share/fonts"                        # 字体安装目录

if_mycmd() {
  if [ $? -ne 0 ]; then
    echo "❌ 错误：脚本执行失败，出现意外情况，请手动配置"
    exit 1
  fi
}

mkdir_func() {
  if [ ! -e "$VARI" ]; then
    mkdir -p "$VARI"
  fi
}

# 检查字体源目录是否存在
if [[ ! -d "$FONT_SRC_DIR" ]]; then
  echo "❌ 错误：未找到字体源目录 $FONT_SRC_DIR"
  exit 1
fi

# 创建字体目录（如果不存在）
mkdir -p "$FONT_DIR"

echo "📦 正在复制字体文件到 $FONT_DIR..."
cp -r "$FONT_SRC_DIR"/* "$FONT_DIR" || {
  echo "❌ 字体文件复制失败！请检查源目录内容。"
  exit 1
}

# 刷新字体缓存
echo "♻️ 刷新字体缓存..."
fc-cache -fv "$FONT_DIR" || {
  echo "❌ 字体缓存刷新失败！"
  exit 1
}

echo "✅ JetBrainsMono Nerd Font 安装完成！"
echo "ℹ️ 请重启终端（如 Alacritty）应用新字体。"

cd ~/WorkingDocument/Manjaro/ || exit

# 克隆 WhiteSur 主题仓库
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1

# 进入克隆的目录
cd WhiteSur-gtk-theme

# 执行安装脚本
./install.sh

# execute firefox Beautify
./tweaks.sh -f

# 完成提示
echo "WhiteSur 主题安装完成！"

rm -rf ~/WorkingDocument/Manjaro/WhiteSur-gtk-theme

tar -xf Mojave-Light-themes.tar.xz
if_mycmd

tar -xf WhiteSurIcon.tar.xz
if_mycmd

tar -xf 01-McMojave-circle-icons.tar.xz
if_mycmd

tar -xf WhiteSur-cursors.tar.xz
if_mycmd

VARI="$HOME/.icons/"
mkdir_func "$VARI"
cp -rf ~/WorkingDocument/Manjaro/McMojave-circle-dark/ "$VARI"
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/McMojave-circle/ "$VARI"
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/McMojave-circle-light/ "$VARI"
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/WhiteSur/ "$VARI"
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/WhiteSur-cursors/ "$VARI"
if_mycmd

VARI="$HOME/.themes/"
mkdir_func "$VARI"
cp -rf ~/WorkingDocument/Manjaro/Mojave-Light/ "$VARI"
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/WhiteSur-Light/ "$VARI"
if_mycmd
cp -rf ~/WorkingDocument/Manjaro/WhiteSur-dark/ "$VARI"
if_mycmd

# 删除缓存
cd ~/WorkingDocument/Manjaro/ || exit
rm -rf WhiteSur Mojave-Light McMojave-circle-light McMojave-circle-dark McMojave-circle WhiteSur-dark WhiteSur-Light WhiteSur-cursors
