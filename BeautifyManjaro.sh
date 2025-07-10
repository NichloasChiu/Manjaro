#!/bin/bash
###########################################################################################################
# File Name:    BeautifyManjaro.sh
# Author:       NichloasChiu
# mail:         NichloasChiu@outlook.com
# Created Time: 2024年02月27日 星期四 22时26分06秒
# Update Time: 2025年07月09日 星期四 10时50分29秒
##########################################################################################################
set -e # 遇到错误时退出

# ===== 用户配置 =====
FONT_SRC_DIR="$HOME/WorkingDocument/Manjaro/JetBrainsMono" # 字体源目录
FONT_DIR="$HOME/.local/share/fonts"                        # 字体安装目录

# ===== 固定变量 =====
THEME_REPO="https://github.com/vinceliuice/WhiteSur-gtk-theme.git"
ICON_REPO="https://github.com/vinceliuice/WhiteSur-icon-theme.git"
CURSOR_REPO="https://github.com/vinceliuice/WhiteSur-cursors.git"

TMP_DIR="/tmp"
GTK_CLONE_DIR="$TMP_DIR/WhiteSur-gtk-theme"
ICON_CLONE_DIR="$TMP_DIR/WhiteSur-icon-theme"
CURSOR_CLONE_DIR="$TMP_DIR/WhiteSur-cursors"

# Firefox 配置目录
FIREFOX_PROFILE_DIR="$HOME/.mozilla/firefox"

# ===== 函数封装 =====
# 检查 Firefox 是否在运行
check_firefox_closed() {
  local firefox_pid
  # 使用 pgrep -x 精确匹配进程名（避免匹配插件进程等）
  if firefox_pid=$(pgrep -x "firefox"); then
    echo "⚠️  Firefox 正在运行 (PID: $firefox_pid)，正在尝试关闭..."
    # 先尝试正常终止（SIGTERM）
    kill "$firefox_pid" 2>/dev/null
    # 等待1秒让进程正常退出
    sleep 1

    # 检查是否仍然存在，若存在则强制终止（SIGKILL）
    if pgrep -x "firefox" >/dev/null; then
      echo "🛑  正常关闭失败，正在强制终止..."
      pkill -9 -x "firefox" 2>/dev/null
      sleep 0.5 # 给强制终止留出时间
    fi

    # 最终确认是否已关闭
    if pgrep -x "firefox" >/dev/null; then
      echo "❌  无法关闭 Firefox，请手动终止进程后再继续。"
      read -rp "⏸️  按回车继续（确保 Firefox 已关闭）..."
      return 1
    else
      echo "✅  Firefox 已成功关闭。"
    fi
  else
    echo "ℹ️  Firefox 未运行，继续执行..."
  fi
}

function clone_and_install() {
  local repo_url=$1
  local clone_dir=$2
  local install_script=$3

  echo "🔄 克隆 $repo_url 到 $clone_dir ..."
  rm -rf "$clone_dir"
  git clone --depth=1 "$repo_url" "$clone_dir"

  echo "📦 执行安装脚本：$install_script"
  cd "$clone_dir" || exit
  bash "$install_script"
}

function install_fonts_from_local() {
  echo "🔤 正在安装 JetBrainsMono Nerd Font（使用本地字体）..."

  if [[ ! -d "$FONT_SRC_DIR" ]]; then
    echo "❌ 错误：字体源目录不存在：$FONT_SRC_DIR"
    exit 1
  fi

  mkdir -p "$FONT_DIR"

  echo "📂 从 $FONT_SRC_DIR 复制字体到 $FONT_DIR..."
  if cp -r "$FONT_SRC_DIR"/* "$FONT_DIR"; then
    echo "✅ 字体文件复制成功。"
  else
    echo "❌ 字体文件复制失败！请检查源目录内容。"
    exit 1
  fi

  echo "♻️ 正在刷新字体缓存..."
  if fc-cache -fv "$FONT_DIR"; then
    echo "✅ 字体缓存刷新完成。"
    echo "ℹ️ 请重启终端（如 Alacritty）以应用新字体。"
  else
    echo "❌ 字体缓存刷新失败！"
    exit 1
  fi
}

function apply_firefox_theme() {
  if [[ -d "$FIREFOX_PROFILE_DIR" ]]; then
    echo "🌐 应用 Firefox 主题..."
    "$GTK_CLONE_DIR/tweaks.sh" -f --firefox
  else
    echo "⚠️ 未检测到 Firefox 配置目录，跳过 Firefox 主题。"
  fi
}

# ===== 主流程 =====
check_firefox_closed
clone_and_install "$THEME_REPO" "$GTK_CLONE_DIR" "./install.sh"
apply_firefox_theme
clone_and_install "$ICON_REPO" "$ICON_CLONE_DIR" "./install.sh"
clone_and_install "$CURSOR_REPO" "$CURSOR_CLONE_DIR" "./install.sh"
install_fonts_from_local

# ===== 清理临时目录 =====
echo "🧹 清理临时目录..."
rm -rf "$GTK_CLONE_DIR" "$ICON_CLONE_DIR" "$CURSOR_CLONE_DIR"

# ===== 完成提示 =====
echo -e "\n🎉 所有主题、图标、字体安装完成！"
echo "🖼️ 请前往 系统设置 > 外观 设置 WhiteSur 主题。"
echo "🦊 Firefox 以生效主题样式。"
echo "🛑about:config中设置browser.tabs.closeTabByDblclick 为true 以启动双击关闭标签页功能。"
echo "🛑about:config中设置browser.search.openintab 为true 地址栏搜索直接在新标签页打开。"
echo "🛑about:config中设置browse.tabs.tabmanager.enabled 为flase 禁用标签管理面板（提升性能）。"
