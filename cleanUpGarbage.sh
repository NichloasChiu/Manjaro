#!/bin/bash
###########################################################################################################
# File Name:    clean.sh
# Author:       NichloasChiu
# mail:         NichloasChiu@outlook.com
# Created Time: 2024年03月10日 星期日 13时46分00秒
#
# 功能描述：Arch Linux/Manjaro 系统清理工具
# 1. 安全清理包缓存、日志
# 2. 支持卸载软件包（通过 pacman 或 yay）
# 3. 搜索并删除残留文件和配置
# 4. 使用 lolcat 美化输出
##########################################################################################################

# 初始化全局变量
findPath=("/usr/local/bin/" "/usr/bin/" "/etc/" "$HOME/.config/" "/usr/share/" "/usr/local/share/" "$HOME/.cache/" "$HOME/.local/share/")
parameterHints=(
  "echo 正在查询可执行文件（/usr/local/bin/）..."
  "echo 正在查询可执行文件（/usr/bin/）..."
  "echo 正在查询配置文件（/etc/）..."
  "echo 正在查询个人残留数据（~/.config/）..."
  "echo 正在查询系统共享数据（/usr/share/）..."
  "echo 正在查询本地共享数据（/usr/local/share/）..."
  "echo 正在查询缓存数据（~/.cache/）..."
  "echo 正在查询其他相关文件（~/.local/share/）..."
)

# 检查并安装 lolcat
function check_lolcat() {
  echo "testlolcat" | lolcat >/dev/null 2>&1 || {
    echo "正在安装 lolcat..." | lolcat
    sudo pacman -S lolcat --noconfirm
  }
}

# 彩色输出函数
function lolcat_command() {
  local cmd=("$@")
  "${cmd[@]}" | lolcat
}

# 主清理流程
function system_clean() {
  # 清理包缓存
  lolcat_command echo "→ 清理 pacman 缓存..."
  sudo pacman -Sc --noconfirm
  sudo pacman -Scc --noconfirm

  # 清理AUR缓存
  if command -v yay &>/dev/null; then
    lolcat_command echo "→ 清理 yay 缓存..."
    yay -Sc --noconfirm
  fi

  # 清理孤儿包
  lolcat_command echo "→ 清理孤儿包..."
  sudo pacman -Rns $(pacman -Qdtq) --noconfirm 2>/dev/null || lolcat_command echo "无孤儿包"

  # 清理日志
  lolcat_command echo "→ 清理系统日志..."
  sudo journalctl --vacuum-size=50M

  # 添加系统更新
  lolcat_command echo "→ 正在更新系统..."
  sudo pacman -Syu --noconfirm
}

# 软件包卸载功能
function uninstall_package() {
  local pkg="$1"
  lolcat_command echo "正在尝试卸载: $pkg"

  if pacman -Qs "$pkg" >/dev/null; then
    lolcat_command echo "=> pacman 已安装:"
    pacman -Qs "$pkg"
    read -p "请输入完整包名确认卸载: " confirm_pkg
    sudo pacman -Rns "$confirm_pkg"
  elif command -v yay &>/dev/null && yay -Qs "$pkg" >/dev/null; then
    lolcat_command echo "=> yay 已安装:"
    yay -Qs "$pkg"
    read -p "请输入完整包名确认卸载: " confirm_pkg
    yay -Rns "$confirm_pkg"
  else
    lolcat_command echo "未找到软件包: $pkg"
  fi
}

# 残留文件搜索
function search_residues() {
  local target="$1"
  for ((i = 0; i < ${#findPath[@]}; i++)); do
    lolcat_command echo "${parameterHints[$i]}"
    lolcat_command echo "=========================================================="
    if [[ "${findPath[$i]}" =~ /bin/ ]]; then
      sudo find "${findPath[$i]}" -name "*$target*" 2>/dev/null
    else
      sudo find "${findPath[$i]}" -type d -name "*$target*" 2>/dev/null
    fi
  done
}

# 主逻辑流程
function main() {
  check_lolcat

  # 参数解析
  local uninstall_flag=false
  local package_name=""
  local clean_mode=true

  while [[ $# -gt 0 ]]; do
    case "$1" in
    -u | --uninstall)
      uninstall_flag=true
      package_name="$2"
      shift
      ;;
    *)
      package_name="$1"
      clean_mode=false
      ;;
    esac
    shift
  done

  # 执行对应操作
  if $uninstall_flag; then
    uninstall_package "$package_name"
  elif $clean_mode; then
    system_clean
  else
    while true; do
      search_residues "$package_name"
      read -p "输入要删除的路径（输入 'n' 退出）: " path
      [[ "$path" == "n" ]] && break
      [[ -d "$path" ]] && rm -rfv "$path" || lolcat_command echo "路径不存在: $path"
    done
  fi
}

main "$@"
